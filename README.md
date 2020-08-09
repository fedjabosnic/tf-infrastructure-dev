# tf-infrastructure-dev


## FAQ

### Submodules

This repository references **stacks** using [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

Useful resources:
- https://www.atlassian.com/git/tutorials/git-submodule
- https://www.jvt.me/posts/2018/05/04/git-submodule-diff-formats/
- https://medium.com/@porteneuve/mastering-git-submodules-34c65e940407

### Adding and promoting stacks

Stack addition and promotion is **automated** with the help of a **repository dispatch event**. Stack promotion is a process
whereby 

To promote a stack it is necessary to raise the `promote-stack` repository dispatch event with the following
schema:

```json
{
    "event_type": "promote-stack",
    "client_payload": {
        "actor": "fedjabosnic", // The github username of the caller
        "stack": "zookeeper",   // The name of the stack
        "sha": "ac245da56"      // The sha to promote
    }
}
```

For example, using curl:

```bash
curl -X POST https://api.github.com/repos/${ORG}/${REPOSITORY}/dispatches \
     -H "Accept: application/vnd.github.everest-preview+json" \
     -H "Authorization: token ${GITHUB_TOKEN}" \
     --data '{ "event_type": "promote-stack", "client_payload": { "actor": "...", "stack": "...", "sha": "..." }'
```

Alternatively, from github actions:

```yaml
- name: Promote stack
  uses: peter-evans/repository-dispatch@v1.1.1
  with:
    token: ${{ env.GITHUB_TOKEN }}
    repository: ${{ env.ORG }}/${{ env.REPOSITORY }}
    event-type: promote-stack
    client-payload: '{ "actor": "...", "stack": "...", "sha": "..." }'
```

As a response to receiving the , the automation will create a pull request with 

Stack repositories contain workflows that automate the promotion of a stack version to environments. In the
latest process this is done by simply tagging a stack commit with the name of the environment. For
example, tagging commit `15da56ced` wit the tag `qa` will promote that commit t to the `qa` environment

- Tag a stack commit with the name of the environment
- Raise the `stack-promote` repository dispatch event

### Adding new stacks

Adding a new stack to the environment is **automated** - follow the normal stack promotion automation will ensure that
the stack is *correctly added and registered as a submodule*.

As part of the environment release pull request, you should:
- Create a new backend file in `.variables/stack-<name>.tf`
- Add any required variables to `.variables/terraform.tfvars`

### Working locally

To clone the repository including all stack files:

```bash
> git clone ...
> git submodule init
> git submodule update
```