let input1 = "sileNt"
let input2 = "listen"

if (!input1 || !input2) {
    console.log("This is not anagram")
    return
}

if (input1.length != input2.length) {
    console.log("This is not anagram")
    return
}
input1 = input1.toLowerCase()
input2 = input2.toLowerCase()

function sortString(str){
  var arr = str.split('');
  var sorted = arr.sort();
  return sorted.join('');
}

input1 = sortString(input1)
input2 = sortString(input2)

if(input1 != input2){
	console.log("This is not anagram") 
	return
}
console.log("This is anagram")