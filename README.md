# <h1 align="center">Hello World Tangle Blueprint 🌐</h1>

## 📚 Overview

This Tangle Blueprint provides a simple Hello World job.
Blueprints are specifications for <abbr title="Actively Validated Services">AVS</abbr>s on the Tangle Network. An AVS is
an off-chain service that runs arbitrary computations for a user-specified period of time.

Blueprints provide a useful abstraction, allowing developers to create reusable service infrastructures as if they were
smart contracts. This enables developers to monetize their work and align long-term incentives with the success of their
creations, benefiting proportionally to their Blueprint's usage.

For more details, please refer to the [project documentation](https://docs.tangle.tools/developers/blueprints/introduction).

## 🚀 Features

- Custom greeting messages
- Default "Hello World!" messages
- ...

## 📋 Prerequisites

Before you can run this project, you will need to have the following software installed on your machine:

- [Rust](https://www.rust-lang.org/tools/install)
- [Forge](https://getfoundry.sh)
- [Tangle](https://docs.tangle.tools/developers/cli/installation)

You will also need to install [cargo-tangle](https://crates.io/crates/cargo-tangle), our CLI tool for creating and
deploying Tangle Blueprints:

To install the Tangle CLI, run the following command:

> Supported on Linux, MacOS, and Windows (WSL2)

```bash
cargo install cargo-tangle --git https://github.com/tangle-network/gadget --force
```

## 🛠️ Development

### To build the project:

```sh
cargo build --release
```

### To deploy the blueprint to the Eigenlayer network

```sh
cargo tangle blueprint deploy eigenlayer \
    --devnet \
    --ordered-deployment
```

#### Deployment Configuration

| **Contract**             | **Address**                                          |
| ------------------------ | ---------------------------------------------------- |
| **Registry Coordinator** | `0xc3e53f4d16ae77db1c982e75a937b9f60fe63690`         |
| **Pauser Registry**      | Obtained from the beginning of the Deployment output |
| **Initial Owner**        | `0x70997970C51812dc3A010C7d01b50e0d17dc79C8`         |
| **Aggregator**           | `0xa0Ee7A142d267C1f36714E4a8F75612F20a79720`         |
| **Generator**            | `0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65`         |
| **AVS Directory**        | `0x0000000000000000000000000000000000000000`         |
| **Rewards Coordinator**  | `0x0000000000000000000000000000000000000000`         |
| **Stake Registry**       | `0x5fc8d32690cc91d4c39d9d3abcbd16989f875707`         |
| **Tangle Task Manager**  | Obtained in the Deployment output                    |

- **Pauser Registry**: The address is provided in the deployment output at the beginning of the logs.
- **Tangle Task Manager**: The address is generated during the deployment process and can be found in the deployment output.
- **Initial Owner**: This address has ownership privileges over the deployed contracts.
- **Aggregator**: Responsible for aggregating task responses.
- **Generator**: Used to create new tasks.
- **Registry Coordinator**: a smart contract responsible for managing the registration of operators in the EigenLayer ecosystem.
- **Stake Registry**: manages the staking mechanism for operators.
- **Rewards Coordinator**: manages rewarding mechanism for operators.

### To run the AVS

```bash
TASK_MANAGER_ADDRESS=0x07882Ae1ecB7429a84f1D53048d35c4bB2056877 cargo tangle blueprint run \
    -p eigenlayer \
    -u <YOUR-RPC-URL:PORT> \
    --keystore-path ./test-keystore

```

## 📜 License

Licensed under either of

- Apache License, Version 2.0
  ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
- MIT license
  ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## 📬 Feedback and Contributions

We welcome feedback and contributions to improve this blueprint.
Please open an issue or submit a pull request on our GitHub repository.
Please let us know if you fork this blueprint and extend it too!

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
