function dismissNotice() {
    const notice = document.querySelector(".js-last-added-appliance");
    if (notice) {
        notice.remove();
    }
}

function initDismissNotice() {
    const dismissButton = document.querySelector(".js-last-added-appliance-dismiss")
    if (dismissButton) {
        dismissButton.addEventListener('click', dismissNotice);
    }
}

export default initDismissNotice