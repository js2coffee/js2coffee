function switchWithReturn() {
  switch (day) {
    case "Mon":
      return work;
      break;
    case "Tue":
      return relax;
      break;
    default:
      return iceFishing
  }
}

function switchWithoutReturn() {
  switch (day) {
    case "Mon":
      return work;
      break;
    case "Tue":
      relax;
      break;
    default:
      return iceFishing
  }
}
