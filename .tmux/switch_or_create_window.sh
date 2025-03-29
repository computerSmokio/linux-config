#!/bin/bash

# Obtener el número de la ventana desde el argumento
window_number=$1
current_session=$(tmux display-message -p '#S')

# Verificar si la ventana ya existe
if tmux list-windows | grep -q "^${window_number}:"; then
    # Si la ventana existe, cambiar a ella
    tmux select-window -t "${window_number}"
else
    # Si la ventana no existe, crearla con un nombre predeterminado
    tmux new-window -n "${window_number}" -t "${current_session}"
    tmux select-window -t "${window_number}"
fi
