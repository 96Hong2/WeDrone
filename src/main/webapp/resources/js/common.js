/* 페이지네이션 ajax 복붙 고 */
/*
content = ''
content += '<ul class="pagination justify-content-center">'
if (data.startPage != 1) {
    content += '<li class="page-item">'
    content += '<a class="page-link" href="?page=' + (data.startPage) - 1 + '" aria-label="Previous">'
    content += '<span aria-hidden="true">&laquo;</span>'
    content += '</a>'
    content += '</li>'
}
for (let i = data.startPage; i <= data.endPage; i++) {
    console.log(data.currPage)
    if (data.currPage != i) {
        content += '<li class="page-item"><a className="page-link" href="?page=' + i + '">i</a></li>'
    } else {
        content += '<li class="page-item active"><a class="page-link">i</a></li>'
    }
}
if (data.totalPage != data.endPage) {
    content += '<li class="page-item">'
    content += '<a class="page-link" href="?page=' + (data.endPage) + 1 + '" aria-label="Next">'
    content += '<span aria-hidden="true">&raquo;</span>'
    content += '</a>'
    content += '</li>'
}
content += '</ul>'
*/
