from faker import Faker
from pypinyin import lazy_pinyin, Style
import json

data = {}
data_list = []

f=Faker(locale='zh_CN')

# for i in range(1000):
#     data_list_data = {}
#     name = f.name()
#     surname = lazy_pinyin(name[0:1])[0][0:1]
#     address = f.province()+' '+f.district()
#     username = f.user_name()
#     aver = f.image_url(width=108,height =108)
#     data_list_data['surname'] = surname
#     data_list_data['username'] = name
#     data_list_data['address'] = address
#     data_list_data['user'] = username
#     data_list_data['aver'] = aver
#     data_list.append(data_list_data)
# data['data'] = data_list
# with open('address.json','w') as f:
#     f.write(json.dumps(data))
# print('生成通讯录')

# for i in range(1000):
#     content = ''
#     for j in f.sentences():
#         content+=j
#     content = content.replace('.',',')[0:-1]
#     data_list.append(content)
# data['data'] = data_list
# with open('content.json','w') as f:
#     f.write(json.dumps(data))
# print('生成段落数据')

for i in range(1000):
    data_list.append(f.image_url(width=100,height =100))
data['data'] = data_list
with open('images.json','w') as f:
    f.write(json.dumps(data))
print('生成图像数据')
