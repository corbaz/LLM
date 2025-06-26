# Archivo: es.py

import gradio as gr
import requests
from bs4 import BeautifulSoup
from transformers import pipeline
from deep_translator import GoogleTranslator
import re

# 🔧 Cargar el modelo de resumen en inglés
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

# 🧠 Función para extraer texto de una URL si es válido


def extraer_texto_de_url(url):
    try:
        res = requests.get(url, timeout=5)
        soup = BeautifulSoup(res.text, "html.parser")
        textos = soup.stripped_strings
        return " ".join(textos)
    except Exception as e:
        return f"No se pudo extraer texto: {str(e)}"

# 🧠 Función para detectar si el texto está en inglés


def es_ingles(texto):
    try:
        traducido = GoogleTranslator(
            source='auto', target='es').translate(texto[:400])
        return traducido != texto
    except Exception:
        return False

# 🧠 Función principal que hace todo


def resumidor_argento(texto):
    if not texto.strip():
        return "Texto vacío", "", ""

    if texto.startswith("http://") or texto.startswith("https://"):
        texto = extraer_texto_de_url(texto)

    texto = texto.strip()

    partes = [texto[i:i+1000] for i in range(0, len(texto), 1000)]
    resumenes = []

    for parte in partes:
        resultado = summarizer(parte, max_length=300,
                               min_length=60, do_sample=False)
        if resultado and isinstance(resultado, (list, tuple)):
            resultado_list = list(resultado)
            if resultado_list and "summary_text" in resultado_list[0]:
                resumenes.append(resultado_list[0]["summary_text"])
            else:
                resumenes.append("")
        else:
            resumenes.append("")

    resumen_en = " ".join(resumenes)

    resumen_es = GoogleTranslator(source='en', target='es').translate(
        resumen_en) if es_ingles(texto) else resumen_en

    traduccion_exacta = GoogleTranslator(
        source='auto', target='es').translate(texto)

    return resumen_en, traduccion_exacta, resumen_es


# 🌐 Interfaz web con Gradio
iface = gr.Interface(
    fn=resumidor_argento,
    inputs=gr.Textbox(lines=12, placeholder="Pegá texto o una URL...",
                      label="📥 Ingresá un texto en español o inglés"),
    outputs=[
        gr.Textbox(label="🇬🇧 Resumen en inglés original"),
        gr.Textbox(label="🇪🇸 Traducción exacta al español"),
        gr.Textbox(label="🇦🇷 Resumen en español final"),
    ],
    title="Resumidor Argento 🤖🇦🇷",
    description="Pegá un texto o URL en inglés o español y recibí resumen y traducción. Automático y directo.",
)

iface.launch()
