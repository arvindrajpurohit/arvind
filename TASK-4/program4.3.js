//let input= "google";
let input= "kaskus";
let character_map = {};

for(let c of input){
	if(!character_map[c]){
		character_map[c] = 1
	}else{
		character_map[c] +=1
	}
}

let output = ""
for(let c of input){
	if(character_map[c]){
		output += c
		output += character_map[c]
	}
	delete character_map[c]
}
console.log(":output",output)