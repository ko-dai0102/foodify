document.addEventListener("turbo:load", () => {
  const tagNameInput = document.querySelector("#item_form_tag_name");
  if (tagNameInput){
    const inputElement = document.getElementById("item_form_tag_name");
    const tagButton = document.getElementById("tag-button");
    const searchResult = document.getElementById("search-result");
    const clickElements = [];

    // clickElementをクリックした際に他の全てのclickElementを削除
    function removeAllClickElements() {
      searchResult.innerHTML = "";
      clickElements.forEach((clickElement) => {
        clickElement.remove();
      });
      clickElements.length = 0;
    }

    inputElement.addEventListener("input", () => {
      const keyword = document.getElementById("item_form_tag_name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/incremental/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.tag_name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            if (clickElement) {
              clickElement.addEventListener("click", () => {
                document.getElementById("item_form_tag_name").value = clickElement.textContent;
                while (searchResult.firstChild) {
                  searchResult.removeChild(searchResult.firstChild);
                }
              });
            }
          });
        };
      };
    });

    const selectedTags = [];

    tagButton.addEventListener("click", () => {
      const keyword = document.getElementById("item_form_tag_name").value;
      const tagShow = document.getElementById("tag-show");
      const tagHidden = document.getElementById("tag-hidden");
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/tag_show/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        removeAllClickElements();
        if (XHR.response) {
          const tagContent = XHR.response.tag_content;
          tagContent.forEach((tag) => {
            const newTagElement = document.createElement("div");
            newTagElement.innerHTML = tag;
            tagShow.appendChild(newTagElement);
            selectedTags.push(tag);
            tagHidden.value = selectedTags.join(",");
            console.log(selectedTags);
            console.log(tagHidden.value);
          })
        }
      };
      document.getElementById("item_form_tag_name").value = "";
    });

    
  };
}); 
