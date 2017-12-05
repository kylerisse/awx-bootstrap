# awx-bootstrap

Shell script to turn a newly built Centos7 VM into an awx server. Will install:

1. docker-ce (edge release)
2. cockpit addons for docker, storage, etc
3. docker python libraries, git, and ansible - required for awx installer
4. awx

This script is not idempotent

### usage

```curl https://github.com/kylerisse/awx-bootstrap/blob/master/install-awx.sh | sh```
