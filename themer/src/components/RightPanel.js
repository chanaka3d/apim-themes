import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Drawer from '@material-ui/core/Drawer';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import UITabs from './UITabs'

const useStyles = makeStyles({
    list: {
        width: 450,
    },
    fullList: {
        width: 'auto',
    },
    menuButton: {
        position: 'absolute',
        right: 0,
        top: 0,
    }
});

export default function RightPanel() {
    const classes = useStyles();
    const [open, setOpen] = React.useState(false);

    const toggleDrawer = () => event => {
        if (event.type === 'keydown' && (event.key === 'Tab' || event.key === 'Shift')) {
            return;
        }
        setOpen(!open);
    };



    return (
        <React.Fragment>
            <IconButton edge="start" className={classes.menuButton} color="inherit" aria-label="menu" onClick={toggleDrawer('right', true)}>
                <MenuIcon />
            </IconButton>
            <Drawer anchor="right" open={open} onClose={toggleDrawer('right', false)}>
                <UITabs />
            </Drawer>
        </React.Fragment>
    );
}
