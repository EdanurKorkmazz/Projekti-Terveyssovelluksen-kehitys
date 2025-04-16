"""
Ympäristömuuttujien lataaja Robot Framework -testeille
"""
import os
from dotenv import load_dotenv as dotenv_load_dotenv

def load_dotenv():
    """
    Lataa .env-tiedoston sisällön ympäristömuuttujiin
    """
    dotenv_load_dotenv()
    return True

def get_environment_variable(name, default=None):
    """
    Hakee ympäristömuuttujan arvon
    
    Args:
        name: Ympäristömuuttujan nimi
        default: Oletusarvo jos muuttujaa ei löydy
        
    Returns:
        Ympäristömuuttujan arvo tai None jos muuttujaa ei löydy
    """
    value = os.getenv(name, default)
    if value is None and default is None:
        raise ValueError(f"Ympäristömuuttujaa {name} ei löydy")
    return value