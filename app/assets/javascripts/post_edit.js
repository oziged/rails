document.addEventListener('turbolinks:load',()  => {
    let inputs = document.querySelectorAll("input[type='file']")
    inputs.forEach(input => {
        input.addEventListener('change', e => {
            console.log(e.target.files)
            let file = e.target.files[0];
            console.log(file)
            let reader = new FileReader(); // без аргументов
            let img = document.createElement('img');
            reader.readAsDataURL(file);
            reader.onload = () => {
                console.log(reader.result)
                img.src = reader.result;
            }
            console.log(img);
            document.body.appendChild(img)
        })
    })
})

