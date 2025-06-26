# **ESKOM PROJECT**

## **Project requirements**

- PIP 25.1.1
- Yarn 1.22.22
- Node 22.15.0
- Python 3.13.5

## **Project setup**

`NB: Commands that start with make need make to be installed. If you don't have or don't want to install make. Look in the Makefile in correspondence to the commands.`

1. Create an environment for managing your python packages
    ```
    make env
    ```

2. Activate your environments
     - Activate your python environment
       ```
       source env/bin/activate
       ```
     - Activate the correct node version `(NB: This command needs nvm package manager installed. If you don't want to install nvm, we recommend you install the node version mentioned above)`
       ```
       nvm use
       ```

3. Prepare your the project by installing the necessary packages
    ```
    make install
    ```

    Note: This will install both packages for the python project and the vite + react-ts project.

## **Running the project**

- To run the python project. Run the command below
  ```
  make dev
  ```
  Note: this will run on http://localhost:8000/

- To run the vite + react-ts project. Open a new terminal > activate the correct node version (see point number 2) then run the command below
  ```
  yarn dev
  ```
  Note: this will run on http://localhost:5173/

`NB: Make sure to run these above commands on separate terminals`