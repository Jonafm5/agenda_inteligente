String formatearHora(String hora24, String formatoHora) {
  if (formatoHora == '12h') {
    final partes = hora24.split(':');
    if (partes.length != 2) return hora24;
    int horas = int.parse(partes[0]);
    final minutos = partes[1];
    final periodo = horas >= 12 ? 'PM' : 'AM';
    if (horas == 0) horas = 12;
    if (horas > 12) horas = horas - 12;
    return '${horas.toString().padLeft(2, '0')}:$minutos $periodo';
  }
  return hora24;
}
