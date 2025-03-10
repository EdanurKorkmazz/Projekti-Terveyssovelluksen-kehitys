import {fetchData} from './fetch.js';

const API_URL = 'http://localhost:3000';


const testConnection = async () => {
    try {
        const response = await fetchData(`http://localhost:3000/api/entries`);
        if (response.ok) {
            console.log('Connection to back-end successful');
        } else {
            console.error('Failed to connect to back-end');
        }
    } catch (error) {
        console.error('Error:', error);
    }
};

testConnection();

// Hae merkinnät
const loadEntries = async () => {
    try {
        const entries = await fetchEntries();
        document.getElementById('entries').innerHTML = entries.map(entry => `
            <div>
                <strong>${entry.situation}</strong> – ${entry.emotion}
                <br> Ahdistus: ${entry.anxiety} | Stressi: ${entry.stress}
                <br> ${entry.notes || ''}
                <button onclick="removeEntry(${entry.id})">Poista</button>
            </div>
        `).join('');
    } catch (error) {
        console.error('Virhe haettaessa merkintöjä:', error);
    }
};

// Lisää uusi merkintä
const saveEntry = async () => {
    const situation = document.getElementById('situation').value;
    const emotion = document.getElementById('emotion').value;
    const anxiety = getCheckedValue('anxiety');
    const stress = getCheckedValue('stress');
    const panic = getCheckedValue('panic');
    const notes = document.getElementById('notes').value;

    const userId = 1; // Kova koodattu käyttäjä-ID

    if (!situation || !emotion || anxiety === null || stress === null || panic === null) {
        alert('Täytä kaikki kentät!');
        return;
    }

    const newEntry = {
        user_id: userId,
        situation,
        emotion,
        anxiety,
        stress,
        panic,
        notes
    };

    try {
        const response = await fetchData(`http://localhost:3000/api/entries`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(newEntry)
        });

        if (response.ok) {
            console.log('Merkintä tallennettu');
            loadEntries(); // Päivitä lista
        } else {
            console.error('Virhe tallentaessa');
        }
    } catch (error) {
        console.error('Error:', error);
    }
};

const removeEntry = async (id) => {
    if (confirm('Haluatko varmasti poistaa merkinnän?')) {
        try {
            await deleteEntry(id);
            alert('Merkintä poistettu');
            loadEntries();
        } catch (error) {
            alert(`Virhe poistettaessa merkintää: ${error.message}`);
        }
    }
};

// Apufunktio checkboxien lukemiseen
const getCheckedValue = (name) => {
    const checkboxes = document.getElementsByName(name);
    let value = null;
    checkboxes.forEach((checkbox) => {
        if (checkbox.checked) {
            value = parseInt(checkbox.value);
        }
    });
    return value;
};

// Lataa merkinnät kun sivu avataan
window.onload = loadEntries;
