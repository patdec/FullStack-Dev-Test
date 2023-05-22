podman pod create --name dualsun-test -p 5432:5432

podman unshare chown 1000:1000 -R ~/Working/docker/db/dualsun-test
podman run -d --restart=always --pod=dualsun-test \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_DB=postgres \
    -v ~/Working/docker/db/dualsun-test:/var/lib/postgresql/data:Z \
    --name=dualsun-test-db postgres:15.2
