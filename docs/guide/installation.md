There is one supported way to get started with RBXLuaAPI.

### Method 1: Command Line
  * Copy and paste this command into the command line: 
    ```batch
    git clone https://github.com/polycue/rbxlua-api.git
    cd rbxlua-api
    rojo build -o RBXLuaAPI.rbxmx 
    move RBXLuaAPI.rbxmx ..
    del /f /s /q *.*
    cd ..
    rmdir /s /q rbxlua-api
    ```

