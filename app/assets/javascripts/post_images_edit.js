let images_to_delete = [];
let post_link = ''

document.addEventListener('turbolinks:load',()  => {
    if (window.location.href.includes('posts') && window.location.href.includes('edit')) {
        post_link = document.querySelector('form').action;
        images_to_delete = []
        let inputs = document.querySelectorAll("input[type='file']")
        inputs.forEach(input => {
            input.addEventListener('change', e => {
                let attachments_div = document.querySelector('.attachments.new');
                attachments_div.innerHTML = '';
                [].forEach.call(e.target.files,(file, index) => {
                    if (index > 5) return;
                    let reader = new FileReader();
                    let img = document.createElement('img');
                    img.className = 'post_img_edit'
                    reader.readAsDataURL(file);
                    reader.onload = () => {
                        img.src = reader.result;
                        attachments_div.appendChild(img);
                    }
                })
                
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