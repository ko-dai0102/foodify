document.addEventListener("turbo:load", () => {
  const tagNameInput = document.querySelector("#item_form_tag_name");
  if (tagNameInput){
    const inputElement = document.getElementById("item_form_tag_name");
    const tagButton = document.getElementById("tag-button")
    const submitButton = document.getElementById("submit-button");

    inputElement.addEventListener("input", () => {
      const keyword = document.getElementById("item_form_tag_name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/incremental/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result");
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
            clickElement.addEventListener("click", () => {
              document.getElementById("item_form_tag_name").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });

    const selectedTags = [];

    tagButton.addEventListener("click", () => {
      const keyword = document.getElementById("item_form_tag_name").value;
      const tagShow = document.getElementById("tag-show");
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/tag_show/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        if (XHR.response) {
          const tagContent = XHR.response.tag_content;
          tagContent.forEach((tag) => {
            const newTagElement = document.createElement("div");
            newTagElement.innerHTML = tag;
            tagShow.appendChild(newTagElement);
            selectedTags.push(tag);
            console.log(selectedTags);
          })
        }
      };
      document.getElementById("item_form_tag_name").value = "";
    });


    submitButton.addEventListener("click", () => {
      const tagsString = selectedTags.join(","); // カンマでタグを区切る

      // AJAXリクエストを使用してサーバーにデータを送信
      const XHR = new XMLHttpRequest();
      XHR.open("POST", `/items/create/?input_tags=${tagsString}`, true);
      XHR.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      XHR.send();
    });

  };
}); 
