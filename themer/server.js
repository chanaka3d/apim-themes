const express = require('express');
const bodyParser = require('body-parser')
const path = require('path');
const fs = require('fs');
var cors = require('cors');
const app = express();
app.use(cors());
app.use(express.static(path.join(__dirname, 'build')));
const apimHome = '/Users/chanakajayasena/Documents/C5/rc1/wso2am-3.0.0/';
const config = require(apimHome + 'repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js');
// const foo = new config();
const { themes: { light } } = config;
console.log(config);

app.get('/theme', function (req, res) {
    const { query: { type } } = req;
    if (type && type === 'original') {
        filePath = path.join(__dirname + '/public/', 'muitheme.json');
        fs.readFile(filePath, { encoding: 'utf-8' }, function (err, data) {
            if (!err) {
                console.log('received data: ' + data);
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.write(data);
                res.end();
            } else {
                console.log(err);
                return res.send(error);
            }
        });
    } else {
        if (light) {
            console.log('received data: ', light);
            res.writeHead(200, { 'Content-Type': 'application/json' });
            res.write(light);
            res.end();
        } else {
            console.log('ERROR: Reading the defaultTheme.js');
            return res.send('ERROR: Reading the defaultTheme.js');
        }

    }




});

app.get('/', function (req, res) {
    res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(process.env.PORT || 8080);