import React, { useState, useEffect } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import MonacoEditor from 'react-monaco-editor';
import axios from 'axios';
const API_URL = 'https://localhost:9443/devportal/site/public/theme/defaultTheme.js';
const muiThemeURL = 'http://localhost:8080/theme';

const useStyles = makeStyles(theme => ({
    root: {
        padding: theme.spacing(3, 2),
    },
}));

export default function SourceView() {
    const classes = useStyles();
    const [code, setCode] = useState('// type your code');
    const editorDidMount = (editor, monaco) => {
        console.log('editorDidMount', editor);
        editor.focus();
    }
    const updateCode = (newCode) => {
        setCode(newCode);
    };
    useEffect(() => {
        const originalPromise = axios.get(muiThemeURL + '?type=original');
        const apimPromise = axios.get(muiThemeURL + '?type=apim');
        Promise.all([originalPromise, apimPromise]).then(values => {
            console.info(values);
        }
        ).catch(err => console.info(err))
        .finally(() => console.info('final'));

    }, [])
    return (
        <MonacoEditor
            width='100%'
            height='100vh'
            language='markdown'
            theme='vs-dark'
            value={code}
            options={{ selectOnLineNumbers: true }}
            onChange={updateCode}
            editorDidMount={editorDidMount}
        />
    );
}
