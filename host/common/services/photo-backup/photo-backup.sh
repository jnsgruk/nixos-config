PHOTOS_ROOT="/data/photos"

backup_gphotos() {
    local name; name="$1"

    echo "Backing up Google Photos for $name"

    gphotos-sync \
        --secret "${PHOTOS_ROOT}/${name}/client_secret.json" \
        "${PHOTOS_ROOT}/${name}" \
        > "${PHOTOS_ROOT}/${name}/backup.log" \
        || echo "Failed to backup Google Photos for $name. See '${PHOTOS_ROOT}/${name}/backup.log'"
}

backup_icloud() {
    local name; name="$1"
    local user; user="$2"
    local pass; pass="$3"

    echo "Backing up iCloud Photos for $name"

    icloudpd \
        --log-level info \
        --directory "${PHOTOS_ROOT}/${name}" \
        --cookie-directory "${PHOTOS_ROOT}/.icloudpd"\
        --folder-structure "{:%Y/%m-%b}" \
        --username "$user" --password "$pass" \
        --smtp-username "$SMTP_USERNAME" \
        --smtp-password "$SMTP_PASSWORD" \
        --smtp-host "smtp.fastmail.com" \
        --smtp-port 465 \
        --size original \
        > "${PHOTOS_ROOT}/${name}/backup.log" \
        || echo "Failed to backup iCloud Photos for $name; See '${PHOTOS_ROOT}/${name}/backup.log'"
}

auth_icloud() {
    local user; user="$1"
    local pass; pass="$2"

    icloudpd --auth-only \
        --cookie-directory "${PHOTOS_ROOT}/.icloudpd" \
        --username "$user" --password "$pass"
}

if [[ "${1:-}" == "auth" ]]; then
    auth_icloud "$NINA_EMAIL" "$NINA_PASSWORD"
    auth_icloud "$RICH_EMAIL" "$RICH_PASSWORD"
    auth_icloud "$LAURA_EMAIL" "$LAURA_PASSWORD"
    auth_icloud "$JON_EMAIL" "$JON_PASSWORD"
else
    backup_gphotos hattie
    backup_gphotos tom
    backup_icloud nina "$NINA_EMAIL" "$NINA_PASSWORD"
    backup_icloud rich "$RICH_EMAIL" "$RICH_PASSWORD"
    backup_icloud laura "$LAURA_EMAIL" "$LAURA_PASSWORD"
    backup_icloud jon "$JON_EMAIL" "$JON_PASSWORD"
fi

chown -R jon:users /data/photos