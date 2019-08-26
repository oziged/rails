document.addEventListener('turbolinks:load',()  => {
    console.log('123');
    if (window.location.href.includes('comments') && window.location.href.includes('edit')) {
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
                    document.querySelector('.attachments').innerHTML += "<i class='fa fa-times img_del' onclick=clearAttachments()></i>"
                }
            })
        })
    }
})

function clearAttachments() {
    let attachments_div = document.querySelector('.attachments');
    attachments_div.innerHTML = '';
    document.querySelector("input[type='file']").value = '';
    let form = document.querySelector("form");
    if (!form.action.includes('?del=true')) {
        form.action = form.action += '?del=true'
    }
}