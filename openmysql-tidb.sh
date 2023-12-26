kubectl -n tidb-cluster run -it --v=0 --rm --restart=Never --overrides='
{
  "spec": {
    "containers": [
      {
        "name": "mysql-client",
        "image": "mysql:8.0",
        "tty": true,
        "stdin": true,
        "command": ["mysql"],
        "args": ["-h", "basic-tidb", "-P", "4000", "-u", "root"]
      }
    ]
  }
}
'  --image=mysql:8.0 mysql
