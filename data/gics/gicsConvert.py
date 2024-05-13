import json
import pandas as pd

data = {}
with open('gics.json', 'r') as f:
	data = json.loads(f.read())

gicsList = []

def getGICS(partId:str):
	global gicsList
	for e in gicsList:
		if e['id'] == partId:
			return e
	print(f'Unknown: {partId}')
	return None


for key in data:
	obj = data[key]
	id = key
	desc = obj['description'] if ('description' in obj.keys()) else 'null'
	if len(key) == 2:
		gicsList.append({
			'id':id,
			'sector':obj['name'],
			'industry_group': 'null',
			'industry':'null',
			'sub_industry':'null',
			'description':desc
		})
	elif len(key) == 4:
		parent = getGICS(key[0:2])
		gicsList.append({
			'id':id,
			'sector':parent['sector'] if parent is not None else 'null',
			'industry_group': obj['name'],
			'industry':'null',
			'sub_industry':'null',
			'description':desc
		})
	elif len(key) == 6:
		parent = getGICS(key[0:4])
		gicsList.append({
			'id':id,
			'sector':parent['sector'] if parent is not None else 'null',
			'industry_group': parent['industry_group'] if parent is not None else 'null',
			'industry':obj['name'],
			'sub_industry':'null',
			'description':desc
		})
	elif len(key) == 8:
		parent = getGICS(key[0:6])
		gicsList.append({
			'id':id,
			'sector':parent['sector'] if parent is not None else 'null',
			'industry_group': parent['industry_group'] if parent is not None else 'null',
			'industry':parent['industry'] if parent is not None else 'null',
			'sub_industry':obj['name'],
			'description':desc
		})

df = pd.DataFrame(gicsList)
print(df)

df.to_csv('out.csv', index=False)