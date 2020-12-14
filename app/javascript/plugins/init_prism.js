const initFormattingToPreBlocks = () => {
  // breaking this up and wrapping in if block
  // to prevent JS breaking on other pages

  const trixContent = document.querySelector('.trix-content');
  if (trixContent) {
    const preElements = trixContent.querySelectorAll('pre');
    preElements.forEach(function (preElement) {
      const regex = /(?!language\-\\w\*)language-\w*\W*/gm;
      const codeElement = document.createElement('code');
      if (preElement.childNodes.length > 1) {
        console.error('<pre> element contained nested inline elements (probably styling) and could not be processed. Please remove them and try again.')
      }
      let preElementTextNode = preElement.removeChild(preElement.firstChild);
      let language = preElementTextNode.textContent.match(regex);
      if (language) {
        language = language[0].toString().trim();
        preElementTextNode.textContent = preElementTextNode.textContent.replace(language, '');
        codeElement.classList.add(language, 'line-numbers');
      }
      codeElement.append(preElementTextNode)
      preElement.append(codeElement)
    })
  }
};

export { initFormattingToPreBlocks };
