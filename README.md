# GH Stargazers
L’architettura é MVVM, ho implementato un infinite loading nella UITableView per gestire la paginazione delle API di GH.

C’é un warning in console (`HTTP load failed (error code: -999 [1:89]) for Task`) dovuto a `avatarImageView.sd_setImage(with: stargazer.avatarURL)` che compare quando si scrolla molto velocemente e le richieste delle immagini di Thumbnail vengono cancellate. Per informazioni maggiori si può guardare [qui](https://stackoverflow.com/a/46558357/68165)

## UX
Nel caso di lista di Stargazer vuota ho deciso di mostrare un alert all’utente e di riportarlo alla Home dove può effettuare un’altra scelta.
Errori generici vengono gestiti analogamente.

## Unit Test
Ho deciso di testare la parte core del progetto che é il viewModel con le logiche di parsing. A questo riguardo ho usato Mocker per fare i mock delle richieste di rete. Il viewModel ha dependency injection per la `URLSessionConfiguration` per poter avere la possibilità di fare gli unit test.

## Credits

- [Alamofire](https://github.com/Alamofire/Alamofire/)
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
- [Mocker](https://github.com/WeTransfer/Mocker)
- Stargazer image presa da [Etsy](https://www.etsy.com/listing/291088149/original-watercolor-painting-stargazer)
