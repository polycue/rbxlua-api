git clone https://github.com/polycue/rbxlua-api.git
cd rbxlua-api
rojo build -o RBXLuaAPI.rbxmx 
move RBXLuaAPI.rbxmx ..
del /f /s /q *.*
cd ..
rmdir /s /q rbxlua-api
