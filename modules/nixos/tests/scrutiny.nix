(import ./lib.nix)
{
  name = "scrutiny";
  nodes = {
    machine = { self, pkgs, lib, ... }: {
      imports = [ self.nixosModules.scrutiny ];
      nixpkgs.overlays = [ self.outputs.overlays.additions ];

      services.scrutiny = {
        enable = true;
      };

      environment.systemPackages =
        let
          seleniumScript = pkgs.writers.writePython3Bin "selenium-script"
            {
              libraries = with pkgs.python3Packages; [ selenium ];
            } ''
            from selenium import webdriver
            from selenium.webdriver.common.by import By
            from selenium.webdriver.firefox.options import Options
            from selenium.webdriver.support.ui import WebDriverWait

            options = Options()
            options.add_argument("--headless")
            service = webdriver.FirefoxService(executable_path="${lib.getExe pkgs.geckodriver}")  # noqa: E501

            driver = webdriver.Firefox(options=options, service=service)
            driver.implicitly_wait(10)
            driver.get("http://localhost:8080/web/dashboard")

            wait = WebDriverWait(driver, 60)

            assert len(driver.find_elements(By.CLASS_NAME, "mat-button-wrapper")) > 0
            assert len(driver.find_elements(By.CLASS_NAME, "top-bar")) > 0

            driver.close()
          '';
        in
        with pkgs; [ curl firefox-unwrapped geckodriver seleniumScript ];
    };
  };
  # This is the test code that will check if our service is running correctly:
  testScript = ''
    start_all()
    
    # Wait for InfluxDB to be available
    machine.wait_for_unit("influxdb2")
    machine.wait_for_open_port(8086)
    
    # Wait for Scrutiny to be available
    machine.wait_for_unit("scrutiny")
    machine.wait_for_open_port(8080)
    
    # Ensure the API responds as we expect
    output = machine.succeed("curl localhost:8080/api/health")
    assert output == '{"success":true}'

    # Start the collector service to send some metrics
    collect = machine.succeed("systemctl start scrutiny-collector.service")
    
    # Ensure the application is actually rendered by the Javascript
    machine.succeed("PYTHONUNBUFFERED=1 selenium-script")
  '';
}
