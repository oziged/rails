document.addEventListener('turbolinks:load', () => {
    console.log('123');
    if (document.querySelector("[data-user-id]")) {
        let input_new_post = document.querySelector('.post_input');
        console.log(input_new_post);
            input_new_post.addEventListener('change', e => {
                let attachments_div = document.querySelector('.new_post_attachments');
                attachments_div.innerHTML = '';
                [].forEach.call(e.target.files, (file => {
                    let reader = new FileReader();
                    let img = document.createElement('img');
                    img.className = 'new_post_img'
                    reader.readAsDataURL(file);
                    reader.onload = () => {
                        img.src = reader.result;
                        attachments_div.appendChild(img);
                    }
                }))
        })
    }
})