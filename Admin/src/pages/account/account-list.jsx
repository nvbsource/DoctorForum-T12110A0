import PropTypes from 'prop-types';

// material-ui
import { useTheme } from '@mui/material/styles';
import AddchartIcon from '@mui/icons-material/Addchart';
import {
   Box,
   CardContent,
   Checkbox,
   Grid,
   IconButton,
   InputAdornment,
   Modal,
   Table,
   TableBody,
   TableCell,
   TableContainer,
   TableHead,
   TablePagination,
   TableRow,
   TableSortLabel,
   TextField,
   Toolbar,
   Tooltip,
   Typography
} from '@mui/material';
// @ts-ignore
import { visuallyHidden } from '@mui/utils';

// project imports
import MainCard from 'components/ui-component/cards/MainCard';
import Page from 'components/ui-component/Page';
import Layout from 'layout';

import { useDispatch, useSelector } from 'store';

// assets
import DeleteIcon from '@mui/icons-material/Delete';
import EditTwoToneIcon from '@mui/icons-material/EditTwoTone';
import SearchIcon from '@mui/icons-material/Search';
import VisibilityTwoToneIcon from '@mui/icons-material/VisibilityTwoTone';
import { useEffect, useState } from 'react';
import { getAccountList, selectAccounts } from 'store/slices/account';
import Link from 'next/link';
import SpecialtyByUser from 'components/SpecialtyByUser';

// table sort
function descendingComparator(a, b, orderBy) {
   if (b[orderBy] < a[orderBy]) {
      return -1;
   }
   if (b[orderBy] > a[orderBy]) {
      return 1;
   }
   return 0;
}

const getComparator = (order, orderBy) =>
   order === 'desc' ? (a, b) => descendingComparator(a, b, orderBy) : (a, b) => -descendingComparator(a, b, orderBy);

function stableSort(array, comparator) {
   const stabilizedThis = array.map((el, index) => [el, index]);
   stabilizedThis.sort((a, b) => {
      const order = comparator(a[0], b[0]);
      if (order !== 0) return order;
      return a[1] - b[1];
   });
   return stabilizedThis.map(el => el[0]);
}

// table header options
const headCells = [
   {
      id: 'name',
      numeric: false,
      label: 'Full Name',
      align: 'left'
   },
   {
      id: 'phone',
      numeric: true,
      label: 'Phone',
      align: 'left'
   },
   {
      id: 'join',
      numeric: true,
      label: 'Join',
      align: 'left'
   },
   {
      id: 'last-login',
      numeric: true,
      label: 'Last Login',
      align: 'left'
   },
   {
      id: 'number-checking',
      numeric: true,
      label: 'Specialty Checking',
      align: 'left'
   }
];

// ==============================|| TABLE HEADER TOOLBAR ||============================== //

const EnhancedTableToolbar = ({ numSelected }) => (
   <Toolbar
      sx={{
         p: 0,
         pl: 1,
         pr: 1,
         ...(numSelected > 0 && {
            color: theme => theme.palette.secondary.main
         })
      }}
   >
      {numSelected > 0 ? (
         <Typography color="inherit" variant="h4">
            {numSelected} Selected
         </Typography>
      ) : (
         <Typography variant="h6" id="tableTitle">
            Nutrition
         </Typography>
      )}
      <Box sx={{ flexGrow: 1 }} />
      {numSelected > 0 && (
         <Tooltip title="Delete">
            <IconButton size="large">
               <DeleteIcon fontSize="small" />
            </IconButton>
         </Tooltip>
      )}
   </Toolbar>
);

EnhancedTableToolbar.propTypes = {
   numSelected: PropTypes.number.isRequired
};

// ==============================|| TABLE HEADER ||============================== //

function EnhancedTableHead({ onSelectAllClick, order, orderBy, numSelected, rowCount, onRequestSort, selected }) {
   const createSortHandler = property => event => {
      onRequestSort(event, property);
   };

   return (
      <TableHead>
         <TableRow>
            <TableCell padding="checkbox" sx={{ pl: 3 }}>
               <Checkbox
                  color="primary"
                  indeterminate={numSelected > 0 && numSelected < rowCount}
                  checked={rowCount > 0 && numSelected === rowCount}
                  onChange={onSelectAllClick}
                  inputProps={{
                     'aria-label': 'select all desserts'
                  }}
               />
            </TableCell>
            {numSelected > 0 && (
               <TableCell padding="none" colSpan={6}>
                  <EnhancedTableToolbar numSelected={selected.length} />
               </TableCell>
            )}
            {numSelected <= 0 &&
               headCells.map(headCell => (
                  <TableCell
                     key={headCell.id}
                     align={headCell.align}
                     padding={headCell.disablePadding ? 'none' : 'normal'}
                     sortDirection={orderBy === headCell.id ? order : false}
                  >
                     <TableSortLabel
                        active={orderBy === headCell.id}
                        direction={orderBy === headCell.id ? order : 'asc'}
                        onClick={createSortHandler(headCell.id)}
                     >
                        {headCell.label}
                        {orderBy === headCell.id ? (
                           <Box component="span" sx={visuallyHidden}>
                              {order === 'desc' ? 'sorted descending' : 'sorted ascending'}
                           </Box>
                        ) : null}
                     </TableSortLabel>
                  </TableCell>
               ))}
            {numSelected <= 0 && (
               <TableCell sortDirection={false} align="center" sx={{ pr: 3 }}>
                  Action
               </TableCell>
            )}
         </TableRow>
      </TableHead>
   );
}

EnhancedTableHead.propTypes = {
   selected: PropTypes.array,
   numSelected: PropTypes.number.isRequired,
   onRequestSort: PropTypes.func.isRequired,
   onSelectAllClick: PropTypes.func.isRequired,
   order: PropTypes.oneOf(['asc', 'desc']).isRequired,
   orderBy: PropTypes.string.isRequired,
   rowCount: PropTypes.number.isRequired
};

// ==============================|| CUSTOMER LIST ||============================== //

const AccountList = () => {
   const theme = useTheme();
   const dispatch = useDispatch();

   const [order, setOrder] = useState('asc');
   const [orderBy, setOrderBy] = useState('calories');
   const [selected, setSelected] = useState([]);
   const [page, setPage] = useState(0);
   const [rowsPerPage, setRowsPerPage] = useState(5);
   const [search, setSearch] = useState('');
   const [rows, setRows] = useState([]);
   const accounts = useSelector(selectAccounts);
   const [userSelected, setUserSelected] = useState({});
   useEffect(() => {
      dispatch(getAccountList());
   }, [dispatch]);

   useEffect(() => {
      setRows(accounts);
   }, [accounts]);

   const handleSearch = event => {
      const newString = event.target.value;
      setSearch(newString || '');
      if (newString) {
         const newRows = accounts.filter(row => {
            let matches = true;

            const properties = ['fullName', 'phoneNumber', 'emailAddress'];
            let containsQuery = false;

            properties.forEach(property => {
               console.log({ old: row[property].toString().toLowerCase(), new: newString.toString().toLowerCase() });
               if (row[property].toString().toLowerCase().includes(newString.toString().toLowerCase())) {
                  containsQuery = true;
               }
            });

            if (!containsQuery) {
               matches = false;
            }
            return matches;
         });
         setRows(newRows);
      } else {
         setRows(accounts);
      }
   };

   const handleRequestSort = (event, property) => {
      const isAsc = orderBy === property && order === 'asc';
      setOrder(isAsc ? 'desc' : 'asc');
      setOrderBy(property);
   };

   const handleSelectAllClick = event => {
      if (event.target.checked) {
         if (selected.length > 0) {
            setSelected([]);
         } else {
            const newSelectedId = rows.map(n => n.id);
            setSelected(newSelectedId);
         }
         return;
      }
      setSelected([]);
   };

   const handleClick = (event, name) => {
      const selectedIndex = selected.indexOf(name);
      let newSelected = [];

      if (selectedIndex === -1) {
         newSelected = newSelected.concat(selected, name);
      } else if (selectedIndex === 0) {
         newSelected = newSelected.concat(selected.slice(1));
      } else if (selectedIndex === selected.length - 1) {
         newSelected = newSelected.concat(selected.slice(0, -1));
      } else if (selectedIndex > 0) {
         newSelected = newSelected.concat(selected.slice(0, selectedIndex), selected.slice(selectedIndex + 1));
      }

      setSelected(newSelected);
   };

   const handleChangePage = (event, newPage) => {
      setPage(newPage);
   };

   const handleChangeRowsPerPage = event => {
      if (event.target.value) setRowsPerPage(parseInt(event.target.value, 10));
      setPage(0);
   };

   const isSelected = name => selected.indexOf(name) !== -1;

   const emptyRows = page > 0 ? Math.max(0, (1 + page) * rowsPerPage - rows.length) : 0;
   return (
      <Page title="Account List">
         {userSelected?.id && <SpecialtyByUser user={userSelected} />}
         <MainCard title="Account List" content={false} sx={{ mt: 3 }}>
            <CardContent>
               <Grid container justifyContent="space-between" alignItems="center" spacing={2}>
                  <Grid item xs={12} sm={6}>
                     <TextField
                        InputProps={{
                           startAdornment: (
                              <InputAdornment position="start">
                                 <SearchIcon fontSize="small" />
                              </InputAdornment>
                           )
                        }}
                        onChange={handleSearch}
                        placeholder="Search Account"
                        value={search}
                        size="small"
                     />
                  </Grid>
               </Grid>
            </CardContent>

            {/* table */}
            <TableContainer>
               <Table sx={{ minWidth: 750 }} aria-labelledby="tableTitle">
                  <EnhancedTableHead
                     theme={theme}
                     numSelected={selected.length}
                     order={order}
                     orderBy={orderBy}
                     onSelectAllClick={handleSelectAllClick}
                     onRequestSort={handleRequestSort}
                     rowCount={rows.length}
                     selected={selected}
                  />
                  <TableBody>
                     {stableSort(rows, getComparator(order, orderBy))
                        .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
                        .map((row, index) => {
                           /** Make sure no display bugs if row isn't an OrderData object */
                           if (typeof row === 'number') return null;
                           const isItemSelected = isSelected(row.id);
                           const labelId = `enhanced-table-checkbox-${index}`;

                           return (
                              <TableRow
                                 hover
                                 role="checkbox"
                                 aria-checked={isItemSelected}
                                 tabIndex={-1}
                                 key={index}
                                 selected={isItemSelected}
                              >
                                 <TableCell
                                    padding="checkbox"
                                    sx={{ pl: 3 }}
                                    onClick={event => handleClick(event, row.id)}
                                 >
                                    <Checkbox
                                       color="primary"
                                       checked={isItemSelected}
                                       inputProps={{
                                          'aria-labelledby': labelId
                                       }}
                                    />
                                 </TableCell>
                                 <TableCell
                                    component="th"
                                    id={labelId}
                                    scope="row"
                                    onClick={event => handleClick(event, row.id)}
                                    sx={{ cursor: 'pointer' }}
                                 >
                                    <Typography
                                       variant="subtitle1"
                                       sx={{ color: theme.palette.mode === 'dark' ? 'grey.600' : 'grey.900' }}
                                    >
                                       {row.fullName}
                                    </Typography>
                                    <Typography variant="caption"> {row.email} </Typography>
                                 </TableCell>
                                 <TableCell>{row.phoneNumber}</TableCell>
                                 <TableCell>{row.created_at}</TableCell>
                                 <TableCell>{row.lastLogin_at}</TableCell>
                                 <TableCell>{row.numberSpecialtyChecking}</TableCell>
                                 <TableCell align="center" sx={{ pr: 3 }}>
                                    <IconButton color="primary" size="large">
                                       <Link href={`profile/${row.id}`}>
                                          <VisibilityTwoToneIcon sx={{ fontSize: '1.3rem' }} />
                                       </Link>
                                    </IconButton>
                                    <IconButton color="primary" size="large" onClick={() => setUserSelected(row)}>
                                       <AddchartIcon sx={{ fontSize: '1.3rem' }} />
                                    </IconButton>
                                 </TableCell>
                              </TableRow>
                           );
                        })}
                     {emptyRows > 0 && (
                        <TableRow
                           style={{
                              height: 53 * emptyRows
                           }}
                        >
                           <TableCell colSpan={6} />
                        </TableRow>
                     )}
                  </TableBody>
               </Table>
            </TableContainer>
            {/* table pagination */}
            <TablePagination
               rowsPerPageOptions={[5, 10, 25]}
               component="div"
               count={rows.length}
               rowsPerPage={rowsPerPage}
               page={page}
               onPageChange={handleChangePage}
               onRowsPerPageChange={handleChangeRowsPerPage}
            />
         </MainCard>
      </Page>
   );
};

AccountList.getLayout = function getLayout(page) {
   return <Layout>{page}</Layout>;
};

export default AccountList;
