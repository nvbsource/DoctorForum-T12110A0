import * as React from 'react';
import Box from '@mui/material/Box';
import Collapse from '@mui/material/Collapse';
import IconButton from '@mui/material/IconButton';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Typography from '@mui/material/Typography';
import Paper from '@mui/material/Paper';
import KeyboardArrowDownIcon from '@mui/icons-material/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@mui/icons-material/KeyboardArrowUp';
import MainCard from './ui-component/cards/MainCard';
import { Button, CardContent, FormControl, Grid, InputLabel, MenuItem, Modal, OutlinedInput, Select, TextField } from '@mui/material';
import { useState } from 'react';
import axiosServices from 'utils/axios';
import { useEffect } from 'react';
import SwipeRightAltIcon from '@mui/icons-material/SwipeRightAlt';
import DownloadForOfflineIcon from '@mui/icons-material/DownloadForOffline';
import { useDispatch } from 'react-redux';
import { openSnackbar } from 'store/slices/snackbar';
import { getAccountList } from 'store/slices/account';
function createData(
    name,
    calories,
    fat,
    carbs,
    protein,
    price,
) {
    return {
        name,
        calories,
        fat,
        carbs,
        protein,
        price,
        history: [
            {
                date: '2020-01-05',
                customerId: '11091700',
                amount: 3,
            },
            {
                date: '2020-01-02',
                customerId: 'Anonymous',
                amount: 1,
            },
        ],
    };
}
const style = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: 400,
    bgcolor: 'background.paper',
    boxShadow: 24,
    pt: 2,
    px: 4,
    pb: 3,
};
function Row(props) {
    const { row, reload } = props;
    const dispatch = useDispatch();
    const [open, setOpen] = React.useState(false);
    const [openModal, setOpenModal] = useState(false);
    const handleOpen = () => setOpenModal(true);
    const handleClose = () => setOpenModal(false);
    const [specSelected, setSpecSelected] = useState({});

    const handleChangeStatus = async (e) => {
        try {
            const { data } = await axiosServices.put(`/SpecialtyDoctor/${specSelected.id}/updateState`, { status: e.target.value });
            if (data.code === 200) {
                dispatch(
                    openSnackbar({
                        open: true,
                        message: data?.message,
                        variant: 'alert',
                        alert: {
                            color: 'success'
                        },
                        close: false
                    })
                );
                reload();
                dispatch(getAccountList());
                setOpenModal(false);
            } else {
                dispatch(
                    openSnackbar({
                        open: true,
                        message: data?.message,
                        variant: 'alert',
                        alert: {
                            color: 'error'
                        },
                        close: false
                    })
                );
            }
        } catch (error) {
            dispatch(
                openSnackbar({
                    open: true,
                    message: error?.message,
                    variant: 'alert',
                    alert: {
                        color: 'error'
                    },
                    close: false
                })
            );
        }
    };
    return (
        <React.Fragment>
            <TableRow sx={{ '& > *': { borderBottom: 'unset' } }}>
                <TableCell>
                    <IconButton
                        aria-label="expand row"
                        size="small"
                        onClick={() => setOpen(!open)}
                    >
                        {open ? <KeyboardArrowUpIcon /> : <KeyboardArrowDownIcon />}
                    </IconButton>
                </TableCell>
                <TableCell component="th" scope="row">
                    {row.specialty?.name}
                </TableCell>
                <TableCell component="th" scope="row">
                    {row.status}
                </TableCell>
                <TableCell>
                    <Button variant="contained" endIcon={<SwipeRightAltIcon />} onClick={() => {
                        setOpenModal(true)
                        setSpecSelected(row)
                    }}>
                        Confirm
                    </Button>
                </TableCell>
            </TableRow>
            <TableRow>
                <TableCell style={{ paddingBottom: 0, paddingTop: 0 }} colSpan={6}>
                    <Collapse in={open} timeout="auto" unmountOnExit>
                        <Box sx={{ margin: 1 }}>
                            <Table size="small" aria-label="purchases">
                                <TableHead>
                                    <TableRow>
                                        <TableCell>Upload date</TableCell>
                                        <TableCell>Link files</TableCell>
                                    </TableRow>
                                </TableHead>
                                <TableBody>
                                    {row.files?.length === 0 && <TableRow><TableCell colSpan={2}>Not found files</TableCell></TableRow>}
                                    {row.files?.map((file) => (
                                        <TableRow key={file.url}>
                                            <TableCell>
                                                <Grid item>
                                                    {file?.created_At}
                                                </Grid>
                                            </TableCell>
                                            <TableCell>
                                                <Grid container alignItems="center">
                                                    <Grid item>
                                                        {file?.url}
                                                    </Grid>
                                                    <Grid item>
                                                        <a href={file?.url} ><DownloadForOfflineIcon /></a>
                                                    </Grid>
                                                </Grid>
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                        </Box>
                    </Collapse>
                </TableCell>
            </TableRow>
            <Modal
                open={openModal}
                onClose={handleClose}
                aria-labelledby="modal-modal-title"
                aria-describedby="modal-modal-description">
                <Box sx={{ ...style, width: 400 }}>
                    <FormControl sx={{ m: 1, width: "100%" }}>
                        <InputLabel id="demo-dialog-select-label">Status</InputLabel>
                        <Select
                            labelId="demo-dialog-select-label"
                            id="demo-dialog-select"
                            input={<OutlinedInput label="Status" />}
                            value={specSelected.status}
                            onChange={handleChangeStatus}
                        >
                            <MenuItem value="checking">Checking</MenuItem>
                            <MenuItem value="accept">Accept</MenuItem>
                            <MenuItem value="cancel">Cancel</MenuItem>
                        </Select>
                    </FormControl>
                </Box>
            </Modal>
        </React.Fragment>
    );
}

export default function SpecialtyByUser({ user }) {
    const [specialties, setSpecialties] = useState([]);

    useEffect(() => {
        if (user?.id) handleGetSpecOfUser(user?.id);
    }, [user?.id]);

    const handleGetSpecOfUser = async () => {
        try {
            const { data } = await axiosServices.get(`/SpecialtyDoctor/getSpecsOfUser/${user?.id}`)
            if (data.code === 200) {
                setSpecialties(data.result);
            }
        } catch (error) {

        }
    }
    return (
        <MainCard title={`Specialties of user ${user.fullName}`} content={false}>
            <CardContent>
                <TableContainer component={Paper}>
                    <Table aria-label="collapsible table">
                        <TableHead>
                            <TableRow>
                                <TableCell />
                                <TableCell>Name</TableCell>
                                <TableCell>Status</TableCell>
                                <TableCell>Action</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {specialties?.length === 0 && <TableRow><TableCell colSpan={4}>Not found specialties</TableCell></TableRow>}
                            {specialties?.map((row) => (
                                <Row key={row.name} row={row} reload={handleGetSpecOfUser} />
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
            </CardContent>
        </MainCard>

    );
}