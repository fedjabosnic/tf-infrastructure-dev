


### Introduction

The ELB2C infrastructure is generally operated using [terraform][] with a few smaller parts [managed manually][].

The infrastructure consists of [environments][] and [stacks][], where an environment is a specifically
configured deployment of multiple stacks meanwhile a stack is an isolated self-contained piece of infrastructure.

The infrastructure is mainly operated using [terraform][] with a few smaller parts [managed manually][].

- `el-b2c-infrastructure`
- `el-b2c-environment-dev`
- `el-b2c-environment-qa`
- `el-b2c-environment-prod`
- `el-b2c-stack-kafka`
- `el-b2c-stack-cassandra`
- `el-b2c-stack-zookeeper`
- `el-b2c-stack-school`


## Glossary


- `environment`: an isolated deployment of infrastructure
    - Composed of multiple stacks
    - Contains environment specific configuration
- `stack`: a self-contained piece of infrastructure
    - Usually manages its own state file

### Third parties

##### Instaclustr - 


### Prerequisites


The B2C infrastructure is managed using [terraform][] and there is heavy emphasis on the terraform approach
to infrastructure-as-code


### Layout and stuff

Environments and stacks can be seen as having a many-to-many relationship. An environment can use multiple
stacks meanwhile a stack can be used within multiple environments. Environments use stacks by adding their
source repositories as git submodules.

The infrastructure depends on a specific layout of variable and backend files, shown in the tree below.

Environments pull in stacks as [git submodules][] and provide configuration. This is
done with some clever file manipulation

An environment has the following structure:

```
.
│
├── .secrets                -- Environment secrets (encrypted)
│   ├── password
│   └── ...
│
├── .variables              -- Environment variables and backends
│   ├── stacks                 -- stack definition file
│   ├── backend-aaa.tf         -- backend for stack-aaa
│   ├── backend-bbb.tf         -- backend for stack-bbb
│   └── terraform.tfvars       -- environment variables
│
├── stack-aaa               -- Submodule to stack-aaa repository
│   └── ...
├── stack-bbb               -- Submodule to stack-bbb repository
│   └── ...
├── stack-ccc               -- Submodule to stack-ccc repository
│   └── ...
│
├── README.md
└── ...
```

A stack repository has the following structure:
```
.
├── .secrets                -> symbolic link to environment secrets   (`../.secrets`)
├── backend.tf              -> symbolic link to environment backend   (`../.variables/backend-aaa.tf`)
├── terraform.tfvars        -> symbolic link to environment variables (`../.variables/terraform.tfvars`)
├── variables.tf            -- stack variable definition
├── main.tf                 -- stack main file
├── README.md               -- stack readme
└── ...
```


```
.
│
├── .secrets                -- Environment secrets (encrypted)
│   ├── password
│   └── ...
│
├── .variables              -- Environment variables and backends
│   ├── stacks                 -- stack precedence definition
│   ├── backend-aaa.tf         -- backend for stack-aaa
│   ├── backend-bbb.tf         -- backend for stack-bbb
│   └── terraform.tfvars       -- environment variables
│
├── stack-aaa               -- Submodule to stack-aaa repository
│   ├── .secrets               -> symbolic link to `../.secrets`
│   ├── backend.tf             -> symbolic link to `../.variables/backend-aaa.tf`
│   ├── terraform.tfvars       -> symbolic link to `../.variables/terraform.tfvars`
│   ├── variables.tf
│   ├── main.tf
│   └── ...
│
├── stack-bbb               -- Submodule to stack-bbb repository
│   ├── .secrets               -> symbolic link to `../.secrets`
│   ├── backend.tf             -> symbolic link to `../.variables/backend-bbb.tf`
│   ├── terraform.tfvars       -> symbolic link to `../.variables/terraform.tfvars`
│   ├── variables.tf
│   ├── main.tf
│   └── ...
│
├── README.md
└── ...
```

Stacks are pulled into environments as git submodules

Each stack is expected to pull in backend and variable definitions from the upper level

 The structure of a stack insists

The B2C infrastructure consists of **environments** and **stacks**, where a stack is an isolated subset of the
infrastructure and an environment is a deployment of multiple stacks.


### Manually managed parts of infrastructure

#### Instaclustr Cassandra keyspaces

In the interest of time, we have manually created some required keyspaces in the cassandra hosted by instaclustr

#### Instaclustr Cassandra users

#### Instaclustr Kafka users



[terraform]: https://terraform.io
"Terraform is one of the most popular infrastructure as code tools on the market"

[git submodules]: https://git-scm.com/book/en/v2/Git-Tools-Submodules
"Git submodules provides a way for a repository to reference other repositories"

[environments]: https://terraform.io
"Terraform is one of the most popular infrastructure as code tools on the market"

[stacks]: #stacks
"Terraform is one of the most popular infrastructure as code tools on the market"

[managed manually]: #manually-managed-parts-of-infrastructure
"In some cases because it is not possible to automate or in others because we hadn't done it yet"