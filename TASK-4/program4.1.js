let input = "11abce335fg11"
//let input = "5abcde3fgh1"

var re = /^\d$/;
let last_num;
let min_number;
for (let c of input) {
    if (re.test(c) == true) {
        if (last_num == undefined) {
            last_num = c
        } else {
            last_num += ""
            last_num += c
        }
    } else {
        if (last_num != undefined) {
            if (min_number == undefined) {
                min_number = last_num
            } else {
                if (parseInt(last_num) < parseInt(min_number)) {
                    min_number = last_num
                }
            }
            last_num = undefined;
        }
    }
}

//for last number
if (last_num != undefined) {
    if (min_number == undefined) {
        min_number = last_num
    } else {
        if (parseInt(last_num) < parseInt(min_number)) {
            min_number = last_num
        }
    }
    last_num = undefined;
}



function replaceAll(str, find, replace) {
    return str.replace(new RegExp(find, 'g'), replace);
}

if (min_number != undefined) {
    let output = replaceAll(input, min_number, "MIN");
    console.log("input", input)
    console.log("output", output)
}