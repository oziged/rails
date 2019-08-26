let images_to_delete = [];
let post_link = ''

document.addEventListener('turbolinks:load',()  => {
    if (window.location.href.includes('posts') && window.location.href.includes('edit')) {
        post_link = document.querySelector('form').action;
        images_to_delete = []
        let inputs = document.querySelectorAll("input[type='file']")
        inputs.forEach(input => {
            input.addEventListener('change', e => {
                let file = e.target.files[0];
                let reader = new FileReader();
                let img = document.createElement('img');
                img.className = 'comment_img_edit'
                let attachments_div = document.querySelector('.attachments');
                reader.readAsDataURL(file);
                reader.onload = () => {
                    img.src = reader.result;
                    attachments_div.innerHTML = '';
                    attachments_div.appendChild(img);
                }
            })
        })
    }
})



function clearPostAttachment(target) {
    console.log(target.parentNode);
    images_to_delete.push(target.parentNode.id);
    target.parentNode.remove()
    let form = document.querySelector("form");
    form.action = post_link + `?images_to_delete=[${images_to_delete.join(',')}]`
    }