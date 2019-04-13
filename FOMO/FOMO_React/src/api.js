import axios from 'axios';

export const fetchTest = () => {
    return axios.get(`/api/test`).then(resp => resp.data);
} 