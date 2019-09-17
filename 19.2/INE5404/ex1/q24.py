days_of_week = ['quarta', 'quinta', 'sexta', 'sábado', 'domingo', 'segunda', 'terça']
months = {
    'janeiro': 31,
    'fevereiro': 28,
    'março': 31,
    'abril': 30,
    'maio': 31,
    'junho': 30,
    'julho': 31,
    'agosto': 31,
    'setembro': 30,
    'outubro': 31,
    'novembro': 30,
    'dezembro': 31,
}

day = int(input('Digite o dia: '))
week_day = days_of_week[day % 7]

for month in months:
    day -= months[month]
    if day <= 0:
        final_month = month
        day = months[month] + day
        break

print('{}, {} de {}'.format(week_day, day, final_month))