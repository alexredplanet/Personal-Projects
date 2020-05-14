#!/Users/Amarsing/anaconda3/bin/python
# Given a string, count the number of times each word appears

s = "When I find myself in times of trouble Mother Mary comes to me Speaking words of wisdom let it be And in my hour of darkness she is standing right in front of me Speaking words of wisdom let it be Let it be let it be let it be let it be Whisper words of wisdom let it be And when the broken hearted people living in the world agree There will be an answer let it be For though they may be parted there is still a chance that they will see There will be an answer let it be Let it be let it be let it be let it be There will be an answer let it be Let it be let it be let it be let it be Whisper words of wisdom let it be Let it be let it be let it be let it be Whisper words of wisdom let it be And when the night is cloudy there is still a light that shines on me Shine until tomorrow let it be I wake up to the sound of music Mother Mary comes to me Speaking words of wisdom let it be Let it be let it be let it be yeah let it be There will be an answer let it be Let it be let it be let it be yeah let it be Whisper words of wisdom let it be"

# Create a list of all the words in the string
word_list = s.split()

word_dict = {}

# Add each word to a dictionary and count the number of times it occurs
for word in word_list:
    if word not in word_dict:
        word_dict[word] = 1
    elif word in word_dict:
        word_dict[word] += 1

# Print the dictionary and number of occurrences of each word
for word in word_dict:
    print(word + ' ' + str(word_dict[word]))

