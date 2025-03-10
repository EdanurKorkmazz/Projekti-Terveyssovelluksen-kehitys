const API_URL = `http://localhost:3000`;

export const fetchEntries = async () => {
  console.log('moro');
    const response = await fetch(`${API_URL}/api/entries`);
    if (!response.ok) throw new Error('Virhe haettaessa merkintöjä');
    return await response.json();
};

export const addEntry = async (entry) => {
    const response = await fetch(`${API_URL}/api/entries`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(entry)
    });
    if (!response.ok) throw new Error('Virhe lisättäessä merkintää');
    return await response.json();
};

export const deleteEntry = async (id) => {
    const response = await fetch(`${API_URL}/api/entries/${id}`, {
        method: 'DELETE',
    });
    if (!response.ok) throw new Error('Virhe poistettaessa merkintää');
};

export {fetchEntries, addEntry, deleteEntry};
