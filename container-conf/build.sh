#!/bin/bash
build_image_base=owncloud/server:10.0.7
build_is_public=1
build_simply=1
build_dockerfile_aux='ENTRYPOINT []'

build_as_root() {
    cd "$build_guest_conf"
    build_create_run_user
    # hardwires the ports, and hardwired include
    install -m 444 /dev/null /etc/apache2/ports.conf
    install -m 555 /dev/stdin /usr/local/bin/occ <<'EOF'
#!/bin/bash
set -euo pipefail
cd /var/www/owncloud
exec php /var/www/owncloud/occ "$@"
EOF
    chown -R "$build_run_user:$build_run_user" /var/www/owncloud
}
