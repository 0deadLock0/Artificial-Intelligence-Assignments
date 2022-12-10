import nltk
from nltk.corpus import stopwords
nltk.download('punkt')
nltk.download("stopwords")

data_file = open('input_data.txt')
data = data_file.read().lower()
data_file.close()

# print(data)

nltk_tokens = nltk.word_tokenize(data)
filtered_nltk_tokens = [word for word in nltk_tokens if word not in stopwords.words('english')]

# print(filtered_nltk_tokens)

def update_interests(old_lits, filter_list) :
	update_list = []
	for o in old_lits :
		if o in filter_list :
			update_list.append(o)

	update_list = list(set(update_list))

	return update_list

def filter_electives(all_list, filter_list) :
	done_list = []
	not_done_list = []
	for a in all_list :
		if a in filter_list :
			done_list.append(a)
		else :
			not_done_list.append(a)

	done_list = list(set(done_list))
	not_done_list = list(set(not_done_list))

	return done_list, not_done_list

interested_areas = ['security',  'artificial', 'algorithm', 'pm', 'optimization', 'ps']
intereseted_areas = update_interests(interested_areas, filtered_nltk_tokens)

# print(interested_areas)

facts_file = open('facts.txt', 'w')

for interest in interested_areas :
	facts_file.write(f'interested({interest}).\n')

electives = ['cn', 'fcs', 'ns', 'se', 'ai', 'ml', 'sml', 'dl', 'ada', 'mad', 'ra', 'ga', 'ra1', 'ra2', 'aa1', 'aa2', 'dm', 'gt', 'lo', 'co', 'm4', 'pns', 'spa', 'si']
electives_taken, electives_not_taken = filter_electives(electives, filtered_nltk_tokens)

# print(electives_taken)

for elective in electives_taken:
	facts_file.write(f'course_done({elective}).\n')

# print(electives_not_taken)

for elective in electives_not_taken:
	facts_file.write(f'course_not_done({elective}).\n')

facts_file.close()
