Part of composition
```
  notebook:
    build: ./notebook
    user: root
    restart: always
    environment:
      - GRANT_SUDO=yes
    ports:
      - 8888:8888
    volumes:
      - /opt/local/var/www/RND/_workbench/work:/home/jovyan/work
```
