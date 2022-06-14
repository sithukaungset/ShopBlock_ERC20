/**
* Space Aware Sharding

*/

const prompt = require("prompt-sync")({ sigint: true });

function removeSmallest(arr) {
  var min = Math.min.apply(null, arr);
  return arr.filter((e) => {return e != min});
}

console.log(removeSmallest([2, 1, 3, 4, 5, 1]))