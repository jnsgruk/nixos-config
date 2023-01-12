{...}: {
  boot = {
    kernelModules = [
      # Help TLP work better with XPS hardware
      "acpi_call"
    ];

    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    kernelParams = [
      # Make sure that the XPS13 actually uses S3 sleep
      "mem_sleep_default=deep"
    ];

    blacklistedKernelModules = [
      # XPS 9370 touchpad goes over i2c
      "psmouse"
    ];
  };
}
