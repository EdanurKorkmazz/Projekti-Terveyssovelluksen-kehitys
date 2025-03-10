import {fetchData} from './public/src/js/fetch.js';

console.log('Moi luodaan nyt tokeneita ja kirjaudutaan sisään');

// Esimerkin takia haut ovat nyt suoraan tässä tiedostossa, jotta harjoitus ei sekoita
// teidän omaa projektin rakennetta

const registerUser = async (event) => {
  event.preventDefault();

  // Haetaan oikea formi
  const registerForm = document.querySelector('#register-form');

  // Haetaan formista arvot
  const username = registerForm.querySelector('#register-username').value.trim();
  const password = registerForm.querySelector('#register-password').value.trim();
  const email = registerForm.querySelector('#register-email').value.trim();

  // Luodaan body lähetystä varten taustapalvelun vaatimaan muotoon
  const bodyData = {
    username:username,
    email: email,
    password: password,
    
  };

  // Endpoint
  const url = 'http://localhost:3000/api/users';

  // Options
  const options = {
    body: JSON.stringify(bodyData),
    method: 'POST',
    headers: {
      'Content-type': 'application/json',
    },
  };
  console.log(options);

  // Hae data
  const response = await fetchData(url, options);

  if (response.error) {
    console.error('Error adding a new user:', response.error);
    return;
  }

  if (response.message) {
    console.log(response.message, 'success');
  }

  console.log(response);
  registerForm.reset(); // tyhjennetään formi
};

const loginUser = async (event) => {
  event.preventDefault();

  // Haetaan oikea formi
  const loginForm = document.querySelector('#login-form');

  // Haetaan formista arvot, tällä kertaa käyttäen attribuuutti selektoreita
  const email = loginForm.querySelector('#username').value.trim();
  const password = loginForm.querySelector('#password').value.trim();

  // Luodaan body lähetystä varten taustapalvelun vaatimaan muotoon
  const bodyData = {
    username: username,
    password: password,
  };

  // Endpoint
  const url = 'http://localhost:3000/api/auth/login';

  // Options
  const options = {
    body: JSON.stringify(bodyData),
    method: 'POST',
    headers: {
      'Content-type': 'application/json',
    },
  };
  console.log(options);

  // Hae data
  const response = await fetchData(url, options);

  if (response.error) {
    console.error('Error adding a new user:', response.error);
    return;
  }

  if (response.message) {
    console.log(response.message, 'success');
    localStorage.setItem('token', response.token);
    localStorage.setItem('name', response.user.username);
  }

  console.log(response);
  loginForm.reset(); // tyhjennetään formi
};

const checkUser = async (event) => {
  event.preventDefault();

  // Endpoint
  const url = 'http://localhost:3000/api/auth/me';
  // Kutsun headers tiedot johon liitetään tokeni
  let headers = {};

  // Nyt haetaan Token localstoragesta
  const token = localStorage.getItem('token');

  // Muodostetaa nyt headers oikeaan muotoon
  headers = {Authorization: `Bearer ${token}`};

  // Options
  const options = {
    headers: headers,
  };
  console.log(options);

  // Hae data
  const response = await fetchData(url, options);

  if (response.error) {
    console.error('Error getting personal data:', response.error);
    return;
  }

  if (response.message) {
    console.log(response.message, 'success');
  }
  console.log(response);
};

const registerForm = document.querySelector('#register-form');
registerForm.addEventListener('submit', registerUser);

const loginForm = document.querySelector('#login-form');
loginForm.addEventListener('submit', loginUser);

