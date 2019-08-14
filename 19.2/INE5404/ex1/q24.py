 import datetime
x = datetime.date(2014, 12, 31)
x += datetime.timedelta(int(input('Entre número entre 1 e 365: ')))
meses = ['Janeiro', 'Feveiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro','Novembro','Dezembro']
dias_semana = ['Segunda', 'Terça', 'Quarta', 'Quinta','Sexta','Sabado','Domingo']
print('{}, {} de {}'.format(dias_semana[x.weekday()], x.day, meses[x.month-1]))
