# _Voting DApp_

## Table of Content

1. [Introduction](#introduction)

2. [Task](#task)

3. [UI Design](#ui-design)

4. [Technologies](#technologies)

5. [Repo Setup](#repo-setup)

6. [Contributors](#contributors)

7. [Contributing to the project](#contributing-to-the-project)
#

> ## Introduction 
<p align="justify">
Pace University employs a variety of administrative and academic professionals at various levels. The organisation has struggled with challenges associated with shifting managerial roles over the years and, hence, wants to set up an election for a leadership position in its school. They specifically stated that system should be based on the web3 technology. As a result, the organisation contacted our team for assistance in resolving the issues. The stakeholders, according to them, are:
  
  - The school board of directors
  - The teachers and Non-teaching staff
  - The students.
 
They also require that the solution proposed to them include a solution to cover the following task listed below:
</p>

> ## Task
_To Create a smart contract that enables the following:_
- _Each stakeholders should be able to vote._
- _Setup Access control for all stakeholders_
- _Only the chairman and teachers can setup and compile the result of the votes._
- _Only the chairman can grant access for the vote to happen.(There should be enable and disable vote.). If vote is disabled, no voting should take place._
- _students should not see result of votes until made public by the other stakeholders._

> ## UI Design

The first page you arrive at is the landing page, where you see details of the candidate that you are about to vote for

<img width = 75% src = "https://user-images.githubusercontent.com/19577206/164324121-6dd96182-2558-4227-bf36-fcf152c19d9d.png">

Next, you would need to connect a wallet to use the platform.</br> **Note** Admin or Chairperson has to whitelist your wallet address at the point of registration.

<img width = 75% src = "https://user-images.githubusercontent.com/19577206/164324131-57e190ee-44e1-468c-84a1-745b50cd609c.png">

Now, that you are connect you would be able to vote and confirm your selection to be sure that your selection is correct by clicking the confirmation box

<img width = 75% src = "https://user-images.githubusercontent.com/19577206/164324138-793c5d93-9a7d-492b-ad9b-e09cb7a04aed.png">

Once you check the confirm box, the vote button is activated and once you cast your vote by clicking vote, you would be directed to the next screen.

<img width = 75% src = "https://user-images.githubusercontent.com/19577206/164324144-09c39ba7-6563-45aa-9c49-50609dbf64ac.png">

This screen confirms your vote

<img width = 75% src = "https://user-images.githubusercontent.com/19577206/164324157-9434d785-078c-41b2-a557-f216f788ba78.png">

The admin/Chairperson page enables the authorize person to do the following tasks such as access control, enable or disable vote, add participants and new candidates and other administrative duties. 

<img width = 75% src = "https://user-images.githubusercontent.com/19577206/164331661-3f0393f3-7032-4567-9a3c-b9c38cb61fe3.png">

For a detailed look at the UI design, follow this link to the [figma file](https://www.figma.com/file/DY7ZEUHLnt5tiVwwI1n08q/Atlantics?node-id=5620%3A2)

#
> ## Technologies
| <b><u>Stack</u></b> | <b><u>Usage</u></b> |
| :------------------ | :------------------ |
|  **`React JS`**     |     Frontend        |
|  **`Solidity`**     |   Smart contract    |

#
> ## Repo Setup

<p align="justify">
To setup the repo, first fork the Pace-University-Zuri.git repo, then clone the forked repository to create a copy on the local machine.
</p>

    $ git clone https://github.com/Oisavictor/Pace-University-Zuri.git

<p align="justify">
Change directory to the cloned repo and set the original Pace-University-Zuri repository as the "upstream" and your forked repository as the "origin" using git-bash.
</p>

    $ git remote add upstream https://github.com/Oisavictor/Pace-University-Zuri.git

#

> ## Contributors

#
> ## Contributing to the project

If you find something worth contributing, please fork the repo, make a pull request and add valid and well-reasoned explanations about your changes or comments.

Before adding a pull request, please note:

- This is an open source project.
- Your contributions should be inviting and clear.
- Any additions should be relevant.
- New features should be easy to contribute to.

All **`suggestions`** are welcome!
#
> ###### README Created by `Victor Oisamoje` for Team-f

