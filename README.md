# Epinio Utils

Some scripts that helps out with Epinio development.

### How to
You might want to give the files executable permissions before running them:

```bash
chmod u+x *.sh
```

#### Generate resources
```bash
  ./epinio-populate

  # What would you like?  all | app | service | config
```
It will generate 2 resources of each type with the format `resource-[RANDOM-STRING]`.


### TODO:
- [ ] Add more resources
- [ ] Choose the number of resources to generate
- [ ] Purge functionality (get all resources by type, batch delete all of them)
