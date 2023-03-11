const fs = require("fs");
(async () => {
    const obj = JSON.parse(fs.readFileSync("data.json").toString());
    const data = Object.values(obj.data);
    let dataNew = "";
    let id = 1;
    data.forEach(parent => {
        const { sub_specialty, name: nameParent } = parent;
        let idParent = id++;
        let obj = {
            Id: idParent,
            Name: nameParent.name,
            ParentId: null,
            Created_at: Date.now(),
            Updated_at: Date.now(),
        }
        dataNew +=`INSERT INTO Specialties VALUES (${obj.Id}, '${obj.Name}', ${obj.ParentId}, NOW(), NOW());`;
        for (const name of Object.values(sub_specialty)) {
            obj = {
                Id: id++,
                Name: name,
                ParentId: idParent,
                Created_at: Date.now(),
                Updated_at: Date.now()
            }
            dataNew +=`INSERT INTO Specialties VALUES (${obj.Id}, '${obj.Name}', ${obj.ParentId}, NOW(), NOW());`;
        }
        fs.writeFileSync("data.txt", dataNew)
    });
})()