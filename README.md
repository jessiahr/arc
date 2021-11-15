# Arc

simple tool for defining rsync jobs

## Install
`mix escript.build`

## Configure 
Make a config file somewhere with json like this:
```json
[
  {
    "title": "Dev folder",
    "from": "/home/some_home/Desktop/dev",
    "to": "/some_path/Backups"
  },
    {
    "title": "notes older",
    "from": "/home/some_home/Desktop/notes",
    "to": "/some_path/Backups"
  },
    {
    "title": "specific file",
    "from": "/home/some_home/.some_file",
    "to": "/some_path/Backups"
  }
]
```

## Run
Start the task by passing a config path to the arc binary:
`./arc /media/some_path/Arcfile
