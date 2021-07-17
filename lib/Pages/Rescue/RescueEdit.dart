import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';
import 'package:nyul_adopt_rescue/components/Dialogs.dart';
import 'package:nyul_adopt_rescue/components/forms.dart';
import 'package:nyul_adopt_rescue/helper/apiHelper_nyul.dart';
import 'package:nyul_adopt_rescue/helper/sqliteHelper.dart';
import 'package:location/location.dart' as loc;
// import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class EditRescuePage extends StatefulWidget {
  EditRescuePage({
    required this.idPostRescue
  });

  final String idPostRescue;

  @override
  _EditRescuePageState createState() => _EditRescuePageState();
}

class _EditRescuePageState extends State<EditRescuePage> {

  bool postAsAnonymous = false;

  void _onChangePostAsAnonymousValue(bool newValue) => setState(() {
    postAsAnonymous = newValue;
  });

  bool _isAmbilGambar = false;
  late File _image;

  late List<Map<String, dynamic>> dataUserLogin;

  _getDataUserLogin() async {
    List<Map<String, dynamic>> data = await SqliteHelper().getData(table: 'login');

    setState(() => dataUserLogin = data);
  }

  TextEditingController _controllerJudulPostingan = new TextEditingController();
  TextEditingController _controllerLokasiTambahan = new TextEditingController();
  TextEditingController _controllerDeskripsiHewan = new TextEditingController();
  TextEditingController _controllerJenisHewan = new TextEditingController();

  int _levelUrgensi = 3;

  _postRescue() {
    DateTime now = new DateTime.now();

    Map<String, dynamic> data = {
      "judul" : _controllerJudulPostingan.text,
      "foto_img_url" : "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wgARCAFsAbMDASIAAhEBAxEB/8QAGwAAAgIDAQAAAAAAAAAAAAAAAAEEBQIDBgf/xAAZAQEAAwEBAAAAAAAAAAAAAAAAAQIDBAX/2gAMAwEAAhADEAAAAew5bqeY8Pp0S40rHey2Y5406cH7fIhkkANNAAAADBcT2ys8Uw6Og7ctYFkTdjoLFxJVj6Hnt1J9lIsrg0AIFBc+W6RB1EXuz26NIPF5Qwe/aY5ADJ5c+k6d/FcApIAUPMdPyvm9GMmLLy6LTZryyz6hp+1ygEwJgAANAAAAAEfzf1DVpHjGPWcv100wrHRaIm7S5WGyDOh6B1HnvoXFoxQaTzPF7q/tpr0t6Vwyk7TTnkoIYYvKUa/TtXQct8kGMgAAFFyvV8p53RrlxJeW9pnjljTp2n7fIgcgAExAJgmJQxCGAhpXNdOpeQRPX+G6q8hHs9etIErDSm37XzmdWfR+e5uHScociVrWNtzJrgsyGC3XETRb+96HK3FdfOMLDCgQJYMQxFHyfWcp5/RplwpuO9tlhtyp0zT9rlAcwgYhqANSAAGgDGYZAjyt8KgsnxzbLlKT0Z6x5/s7xy8/kdwHCQvSQ81i+p4THllv2SiaS4kysZykszkERAMSgECaSxNAAUnK9XyvndEeZEl5b2uzDPGnTZYv2+VoJgYIQwQANak7Y1c7wYSneFmnc0MZuxNYsTNx949Tq4m4E5gTBABp2EIsjPCqwdJPpM0FUARLExAIACl5Xq+U87fVKjScui3zw2Y06PJHucjE5gTIlMSGiHLKAbNYyBXN4syevA35a2bDDEypJO2LTcUjGRvVL12cePfO62aMpgQgBIYAa80RreBEpa+UeRmGKADhiMKblOr5XzuiPOhTMt7fLHbln0QHt8o0WhoIkagSIK3axklrtG7LXkZGOBGmwJ42okJGvNxpG3Qrg1zApYATq5zqKq1XLh52rJMVNMiLtNggZiDEIh2saPW16tW3E00AyVPynV8n5nRpmRJmO9tt155Z9EB7vKATACTHqsLLSI63aLwU+4lZZadkHRWOMXnZadCuVjvdNHBnETjkCQYIaAAUGeSrN2Me2cimuaOa3xrjzEwxRmRJAxENN5UY1m7aVDAlT8p1nJ+X0aZcKZjvc7NezLPoQPc5Aak6a35+yaGrWM9ZDKuwrSyz2lhS2muvMq6QbNlQAk17I5IIOcpgnATQGOQBDJceQ5UmN3U2pDlwJ0xlvr7CaRJcSUMEPXsISLDneipIBVU8l13J+ZvHmRJmG9xsw2Z0v2P3eRDJVBEm6NIi0FHc8xLfOtayus+2HSwBAAAAABMYAAhkDKZiQd0lgAIYKrtVMc5YR9F890qHLmu2DZQYbzDOWO/TqrN+BzzU8p1fK8G0eZCm4b3O3Vuzpfg/d5FCm0di2GGsNMKnbC6yujcPKmkt4tDEwEDFBJ5BmjaYACGgAAAAAAAAXN9LHmKWXT2emNitewqp0GcEKaoWZyRWeg5XquW8reLNhzsN7bdq2Z59A0/e5VzNxW2bALwaJEeJlzG6bcxA7WNM8pLqbS9JG+so0dvhw2ma90+E66t7S1jSqWGnAAEAGrbGJDp7I3CYJoAAEzmJc+Hem/bqLZwZ0GcM25IryQJ28p1nKeP0R50Obhvb7MM6Z37R7nNRmjfrUAkYaZ1dJoFLgyY8p3dvzfTxVdR0Mffjo8LnO0Ufq1J2XJ6LA5+pgAmgACBPDjdlvCvG+XA5yY7jd5zgj0rHzfNPoGPMWNb3VfLjM9oF6QJ1dYIkbYskigQ28v1PM+T0RZkSbz722zHOud7r2V/uctVJxy0gAlT9PyfX11AdLAAJsxMkYmTRi2JAAAAAEwQBT8b6TyO/PTc9ZxevyoWE7C9IBKlZ9Pod3Hkef68SNv0TTITtnWT62fZvz15VbDMRjzfTcz5PRHmw5vPvbbNexnd01zz/ALfNmMvBo31Uo/Xc70ddRp0sAAMAAAAAAAAAAAAQwQ0YxJpMUeroC1KWz3kWQKsxNOzXaoNXzp51fKsnZYlW80BL5nqOY8nePNhzebe2zw2Mrnnuh5v28JAF4VDfcrM9PbRpGeracBoGAAAAAGuY1ZRJBlnhiSMoTJhBziZYAACGgTATQgCuWGd82mrVopUOVaLJ4Z1MAmcz0vOeVvGmw5vNva7MM5yt+ZvKj2sNwFoi0Vjha3U5YvHQYDABgAAAAAAAAAAEWUCYAAAIBoE0CCVVs17L5mOWM15+VH22W2WOVYwKcT0/OdJznl7aJkSZy7WmeOU5bIm/T7eDSLRRWFL0C900ZaN4syEGRixgAAAAAAAAAAAAgASACQAAIAqN0ffpmYvGaYYVnQU6I7j7r8/MHQFlvzvR875O+qXEl8u1nkspx1YI9vF4ZRbRQdHzl+vfCyy0WWOQACYGQCABAAkAQAAAAIYgYknIElAjJAIMJU0qLKvktW2NMaL6JLy6KYWnXAN5rW45/oOe8bfVKiy+TW0aytlCzwy9vF1dlTXiDZ1mc27kWWOw0RGQgyEDEwTFQBYAVTATATBKYJQwBA0AJgocuulryFpg4kiNFruvl1NdJNfYRr4suzWTneh57x9dMyLL49rNj0yr89G/2cCgvucu1AWddP5bqcd20VltCGJg0DAAAAAABoATAABA0AJoYhCrbGqmc01pgocygTla8/fWSteREXAiWPPdDz/lb6pUSVx62rT1yrNuvP2MFzXSctoyETGHeeadPTbq2jK7aBiEMTGIkxAwUGIGIGIGIk0ACYCIAAqe4pLRJxavic50XMTON/QXcxMeqGTC6JLn+goPJ10yosvj3tGnrlAWWHsYrk+s5DSNwiUHNbFvQpPJ9XjrkIrLEwAABA0DASISMkAxMAQAAAkBDEBRXdHasrF43xXK9JzFmy7pLeYlx92lPTnGkv/EAC0QAAEEAAQFAwUAAwEAAAAAAAEAAgMEEBESMgUTICEzFDAxIiM0QFAVJEFC/9oACAEBAAEFAnJ+5V94Td3v8ZpdyOh3ZzXdHB5uXb6eL2eRATgXAIyLM4gZpoy6OEcP9QQMhi5SD61X3pu733AEcUpGvJjIMGPxYcjVk50GMrxHHcnM8xKc/oDSUGdNOu6xPDGIougqTeq+9N3foTxtmjv0H1nEYEZgjIpjskDhwGTVWx43azRKe7PENJQaB1RxukdwykKsfSU/eq+9Dd+i9jXt4hwx0aIwe3PFhyIXBJtFrC7OK8Eji50jsACUI8urJQwvlfw2gKw6ipN6r703d+ne4Y2ZTwPhfknsxicoZeRMOMsKi4nXeuM2mzSSOyQGabGsunJRxOkNXg73KvWjrt63J+5VvIhu/UsV47DbvDJIVknNBRYRgXZtwYcmhhccssclkmsJNfhs8yr8IiYooWRj2SpN6r703d+mXAI2IgjbiV2KOdNo2Chw6dHhMpX+EkX+KlCPDZwhwycF1OcJ0T2qON0jo+GWHKLgyi4XXYmQxs91yl3qtvTN3vk5B1uIIzTvXLlcvTRoRsCy9otBRrRlcpzUJZWKOeN59k9BUm9Vt6Zu92WeOJGxLIeTqTWtb7esczrcxrllJGmWRmO/tuUm9Vt6Zu9uSRsbXSSzJkTW9eSPwidIik5jU94YHNLJvZIBAjfE6OcE+yVJvVbyJu72pphGvqf7AKzWaJyE2dlzRkHODWxRkumZzI679Ucbvuhf+j1uaHASPgLHB46ypfIq3kTN/szzaE0dcbtYxc4NDvuCuM09wYI4yThKOTPLJyrmB9kh0ToZWyt6nKTequ9N3exYn0JjNPXOdTgMhg94YGROkdMedM+TSoYyDjIwPZJ2MZ0H25GODq8wmZ0lSbyqvkTd3XZn5aiZpxc4N6HvDG1QdOEkuRhgydal5bYQ5zYYmxDpvQGSPSZ68T9WM5yja7U3rI0PieJGdBUvkVbyJm7qnlETI4yssD2DXGWUYz52ZR8LU6YwxNiCdWY6UDIexZjJUUokCd3FCUg+xmYXtOoYlS+RVfIm7uknINJszf8Af+K29Vx2DhqXed9fJzpJGxhkUk6a0NHuzwazHJmVOzl2wcw6TTLhCSR0V38l+JUvkVXyJm7pvPzLAGMz7E9inO1SahFDTBLJXFzpQIakbtLYK2TugOBPtzQtlGp0Rst1w1ZPpnbrjhfzI0ztP0SM1tpza24FTeRVd6Zu6HHIQZyF+Nt+mFqnbz3Sv5ba0PKZNGJWRxtjHTLHrWuVqDpCegHMYSS/Xg4BwfA+NQxOIhk1ti+3Oj2n6SeTPgVN5FV8iZu6L7swwZNxsu1yxsMsji1s9WIk++5ro3eoYjK56ghEY6bURzlcHMBzE/Yo7Zjpdg4am0HkxIqbyqt5Ezd0A82w/ti92lmZVWEQQ0ozM79HIezYi5RqO+m0ftD4b3bcZ/rsObMGu5VpFTeVVfImbsbknKgqs0MJzOF5+TeHwZlNAA/aIzU0Ppp7Z+xGc427JRmymc6+FtpdDEdcSn8qq+RR7sbbtdnPtjp9VbaMhLNyyydjlnn1H4JnzD5s/wBKZnMje4+mr+DNf+avboNmaAqfyKrvTN2B+IjrdjO7RFUgbBErLJM80HEJs7whbeE26hbajcCN0r1TioyXn2Nbc/a4mzS6r4ENsfayiMHxguU/kVbem7sLj9EDBpbjlzLGL4I3LiMggnrVXTRWon1o/VsRtsRur1pK4fF6iCKFsfsz6AxjmFMzy9i1GJIIBlDge1tDuMuyKn8iq+RM3YXHarPRS+o9F9jm2qt2WBtq3JOslkiEAuFMLKXs3Ga48k18kaZcIQtxoWIyhI1a2oyMCM7AvURqRw5MHiwm7Tpu3/0ipvIqvkTd2AOuxjYfy4ajdNfovUm2k7hMoR4bYTqU7V6aVNpTuNLhRDx7fEAwQUIXSVp43RNfbgKNmIj1TAvVtQtsUTnyCOOQqT6a0ezC12eECifrI7lTeRVfImblKdMdcZRY3vqTezf1uKtLqda7JXVu/LO0hZIhFBcHz9CrX47dmFxNwb8u+SpvIqvkTNyvHKuPjEHmXP1z8W+F5mSCWM5LSi1Fqq1XzyQRiKNXPx27cL3xHtQ+XbipvIq3kTdyuuzmxmdpj4eP9n9kjNPrROTuG1yv8VAm8NrtMcTI8bXgHxhf+YT9GBPcqbyKt5E3cpfqu43j9HDG/c/g3Pxx8YXt1fbiVN5FW3pu5fNnG0c5+Gtyre7zW6+Yxc2NB7T+jeP2BgVd8tX4xKl8irb035Ufc4FOOart0Q+4/PTHUYByI1ymLkRr07Fy3hapWoTsPu39mNzvZq/GJU3kVbem7ichW7w4WHaYYG6p/wBWWIP925vxtflVcc8JvIq29M3Wnaa8Qyjwvn6eHN1Wv4VnvYxlilknqHPGeXKUqXeq29N+eIHKoMbRzscKHb+FL3t40yMp4+VLhLCZJFLvVbyJu7iJ+jEnVNwr8b+F82sCq8Yy08yCA5xk5CpHnXUm9V96b83z9zBxybHt4V+P/Ch7nB5yZXb9poyEPzZOmCGaYRKTeq+9D5u97eFp2mBnZvC9v8FxybW8OFg5Q149EZ7CDbd8Y+FJvVbfhY/Pw4gcoFw92Vj+DbOVdgyZhZ7xj4uPOloybZ7zIqTeq2/Cf87DiBwjdom/g3/x8Ztz3iNkWbnJjeZdyGEu9V9+En5uF4/fR7ilJzK/8C78YynKaxOZ3xH6FT72cJN6r70Plx/3sLRztYcMk0zfwLPezjxDvMFDsXD+4wk3qDev+v8AzsJjnZwe/lmJ4ez99/e5jaOdhQ7Fw7tVNqYlSb1X3L/sv52B82FzZwWfOL98d7GMpznUGxxybD96No0gqTeq+5D5n7XcB3dhL9U1YlkcMglj/ehOZwJQOeFc/RL4qQ9MflFSb1X3oKx+Yj8R4x95a2zhTiJR+6VB8HCftEzYq2yXws7xGaRq/8QAIxEAAQMEAgMBAQEAAAAAAAAAAQACAxARIDAxQBITIVEEQf/aAAgBAwEBPwGOjtoqdUdHabIjAUOqOh1kV4V8fFWxiRR133xIo6L5W2RIo7LIKyI1xop2sBWwI1Roo6LfEAgMyFbRGijmAraiERnEijxlbcRlEiji0dWKjsBX2C9kZGhe5ia8O41vxjocG1lide7U6GZCOT8X88ZaPuRcAvNq9jV5to/GNHFuydjj9Ck9n+rzcovJxQT8YkUcBtsvW38QaBR+MSKNR0n4xIo1HSdjGijUdI08flY0UUaM6RoSjSNHiho3nphOrEjQ1HSCJrEjQ1aeg7jKNHihwG93GX//xAAjEQACAQQCAgMBAQAAAAAAAAAAAQIDEBExEiAwMhMhQEEi/9oACAECAQE/AWSIewu8XxZGXLpNZV6cMsx1f0Tll3Y9EPYXghPiRly6VFh2px4rrkqVM9JD0U/ZC8KlxIVc7u4JipY6ckOsObl1mPRD2QvBxbPjOIng5HI5HMc2OUvBMeiHsLXZQFHx8Rx7THoh7C6xj3yZ7uPWZLRD2Froo9smboz2aHeQyHsLV0u2e+ezV5j0Q9hWiujM+JPs1gyVB6IexGyu5filaoPRBf6FoV2/OuvEqD0Q9haF14nxtnxMcOPjT61B6IewhWd6dSOPsVSBziVpqX0uyWTgz42cGYF1q2p+wry8lKSX0yPH+GCWEiQutW1P2I3lvy5ObHJuy61bQ9iN3+GNlq9W0NkdW/n4l1ratD2I6s9fiVs3rWj7EdWlr8qMFe0NkbP8iEZK+rR2RFaW/wAEd3wK1fVobI6Faa/At2Vlavo/pDZHQrvzqysjB//EADMQAAECBAMGAwgDAQEAAAAAAAEAAgMQESASITEiMDJBUWETcYFAQlBSYnKRsSMzoYJj/9oACAEBAAY/AkbB5+weNDH3XZ2AHR2V2FvG7LcZW+JFGwP9VBpabB7BQ6Ikf1nSyss5gjUJj+osLnaBF5llumsHqmsboLjYPYSx4yKrqzruSz5TZ4LD928DWjNZ8Z1vNg8/Yi1wqCi+DtM6bjAfem55RJ1OaoJZbjCwVKxOzibg2Dz9kxQ9l6wxBQyqNZ0KZE5NK/qdRZnCe6ayGatE876MaSqxzhHRUht3BRsHn7LSIFiZtstpzma9ViddkCuHCO6/lOIrYaBuzYPZMys3hcz6KsODEa/yX9a4VnhXG1cTVyRJbVf1lbTSqMFVw0X8sT8LNuI91ssA3xsb5+wZqgOI9lsMDR9S24x9FnV3msmjd5hVw0PZfxxXjzW20O+1UBz7782Dfbbl/EzCOrlWK4vWQpu8Hva7jML+J9R0cqRRgKy3hsG8xOKy/jZ/qyGfW+irIk6LENJVKZHdz2TuswqwXZfKVR+y7dmwbvq7oqxPx03dSmsGTK/lADRVKxxfQdE5qz1GSe08t1Qhbe3D/Sq05bk2DdYW5vKqc3X15WVKLomzCH+rGdT/AIs1jia8h0nj9x+TkyujxTeY4Pq1VbuDYNzgZnEKqTVx1N4hN1OZVBOpWONpyavDHA3NywsGJ3RYomb/ANWFp0TGxPdNCvDd6bzxIOT/ANqo15i82DcYW5xDoiSavOpvLjoEYjuJ+c8LBif0WOLtP/SoOM6LDC9XrLXrdVnGmO0iBUOTxqJkjkgRuPEh8X7WIXOsF9TryRiP43WV5WMZ7mss1hg6c3LZ/MvEdmVQabnHD4wujuYkQnwH6s3ONvCeIKo0tdYLs14nuDJq7BEyDBqZU5ywj+scRTonoFVyrF2Yfyqg32JmzEHNYXjC/pIRghRNB0dNwPJ1vhngdw2mwXNgt1dr5LKVJOd6BFztEYjtX5rwoXEdT0TgzpRNhQhiescU4n/q0jnvM9eqwxvRyNNdQgDo7MLLXUIGUQettEWv425Gx1gtJPJGI7V36s7nJAJjfcqg1nEcgFnxHMlYXaKjRdkaO6raZi7tQ2KDvblMQ2Zv/U6EZKsLNvyqIwAim01Z5PGoT2cnbQk3ypc2KNNHWOsFrYQ1drb2agxvqnO92GMIXixOI6dvYMUMVHNqzqFSC3/oo83HU3eLD4hr3TYrfdVUw95sPekyCvDdxQ8pusFr38hshATJX1OX1c0XvGzWvtZe3gPEEWV4VXvN5Grc0DNp5Pym6wWOcNdAmg8rAzqvGf8A8yoNPa8140P+s5OHROTZPCb+JnDqM013USdYLGM5N2jaQOEZFUGizC1vyWjKLOGPz7G5p5p7HcTckzykVEb0dZ4bRk2TrBY+J8xsPXQINGvOWYqFqVk5av8A2tfyFnhWf7WQXCFqAs3upuaV3eMaOyKZ5SKij1srJ1gm6mpyCAsY3k3aszaFgg+qEQFuaxO081m1yya78rJq4UIjjRZbmrxVbDy1Zuxbl4PRM8pt7tkE4TdYJw4fJoxWxInU2xMXVUa7JbZythg67rKvou61IW2JcS1Wq4gtVqnkdEzynCMzM2CcZ/en4sc5MHOltdH9VskFcK/qK/qcsoZWKP8AjeOcW5oO8U17oucxrgOa0cFkSuJcS1Wyz/FmxO8k2cL7rnWCTj2Q752Mh96oezuoqN0VDpcysnps4f3TEzYJEfNlaPP2jNF0E+i22OtDWhNYOUnoTh/chMyNglCZ62OKb2Ffas1nDauFc1w1Ww0Cb7IXmhabBJ30tpYG9VEd6fAnWQrnWCUbzpZ9oQPM74jouILjCyI9h9bIdxsEojurrHn5imjtvTh1W1mea4AuBq4VlUeq2Yh9VtMr9q1z6b1g+qxn2o2mwSB65zcVCb6+zA+8DXewh3s9EbTYFEP0po7Ta3qU4/KPgcIetkR0PMBGbhWRsCd3ysp0Cinv8D8m2PP1rxRocnTc4dZGwKG35n2RD3X/AF8Din0sx9TVFp5oV1GUmnrI2BQB3rMqvVEfV8DiO6umUwSidnJ57JgDBpI2wuwm89kFEHevwIlNPXOb0KyLvmNUG/M6kzb/AMTp1NJEfMPgUTyQE6SENnE9UChD1mbT9s4Q7yY7v8C9RZCHV6LnJ0V2rv1IV91szbE8hOGO1ZtPPT4DDHV1kKvWq/8AMaISjnplM2xvSZ7CboR0dmPgMIdM7IY9ZCUV3V0zbF8hOJNkQatKDhofgDuzbD2EhIk/MSqw4VWcjI2xPITiH6pgBeE7UafAIpsee8giocBumr1QaSNr/tm8/VOnQKHEbq1Nc3n7fEP1WE95u8kC7giDXpM2n7ZnznEk+H7vt5+6bvJCb/JNB6KgeaBf/8QAKhAAAgEDAwMEAgMBAQAAAAAAAAERECExQVFhIHGhMIGRsUDBUPDx0eH/2gAIAQEAAT8h1HniR9FXL13JrR4IgfTJ7BVn5ruqdfouFSdJc8DdrSRnQCBWeVkEQEJjo1EC+SD6RHni9drutoI7l923A1W0tlGK1T86JXStt3hEjfc4WyLFyazW6QQs3MdGqnlshecLjq+XT6aef+DKIJkhPikgkExjE6N7SQTJWddkrEV2/VKbGiHTSbHOdKQ4k3wjUq+wunWeaI+uniheoqTRimVk0xug/kIu0iysqts0oU7AvmrCLxC7l9NkiZ/IOxhQrK7II6S2+8yxddhW6tR5dPrqy/CatA2b1taMcHV+RicV5hqKSbxKam4gxnuCyt4AgDftrVke2WOe1yC9zqdIEF1h4RAcEZIolzqI1oxdB59Pop470oI6Y6IIzXzqiR/aKjKmOujD2Zd2oWC+Bc2PiShQQiCKJkGe7IuXcmMfBaEGS8L0FX5NPrEeehUj8HGy7lvHdL4zPb5KxmQgN6V3YjDdUNKEwwyf3E8fdQDEv2Jt32Lu072W0/YUyRyDwtKr9N5dPpri6V1qqpmhcjmVtrJ7xpv0fovAsi9zJbU/YgrQQR1QQYgY690sF+6BCaw75fBZB22emXR88aPpIPLFjpXoYQnbUgH9GwXZdtNvgwn2dCVp67qVis9DF7P3wi6XnwMklpXUunUebT6aeWLHpuMJItDya6i5yb131I0bMkJULYYTLEa5xRh/1LcTeDZaCouuNKa5LQPtyJXA/T+fT6KL8osC9FVGTC5FIo29NHoInJOHySiBTGQkO8W/RoEYwP7oZqaMhhqhyuW7krbcNDLdhY+u/kiOS3dQmzG19F5NPrpf3ReijsAtiFt8mX1NwpeDCuBNWFsJElrLgNRrjCthKNWFv0DCgf8AsNxDmqBEjT0TV00Me2yfvdPKounUXv5p9NPPFj0Ji2CtuS9yI3Wkk9D93jshSMCtWevZbilYT2+49P7E2FstgoSim/qOjN6RNVl9+T1HS91nuuiel1ndHlaLyYqLZ+jFR11nk0fQI8/0EJxttyXZXrda5wTq5mESPfowtK56uE07j5L6ewv79LklA0nm1ZCVuy2X1PTITyLE0tO5BaakZn1wvEmumKSNgOSCBh+ur5FPqp5fWx8RN2al+DgTNxAxpG9BwlxVTcKWRg2pSW6ESRLQlLKBfrS+xCLm8tl0ga8UPAhCI9BGxC2MfPBsAz5VE5RGYityuielP7n+yJS+W16NR51PpEef1IY8ENDbL+zIZjUuj0uW9i+Y0yuykMuj3TgiJWb9lEh425ImfS1vuIKUktF614tBuJWI5bXtTeqoYtjBjlvafNXiy3Lo4ZBtuXbPbp+San008vqew/TE5SNEae5KmwaFI40T4wiliuIZZstBPd4yW0sHLGxzK+yP+Bvs6dEr1NI1wuUQ11aOGbbgZohL+iUWH5BGp696d6R0kNf2ew7OvuDpmN8wz6RHk1dEvUJJZB+/bjQNhaKsl2RmF2nK1bkfJBK1HfTLs+wijXVZNisIYfchBic3pTM0qsKmbPCsbT5DGXmkiZ3dHsSSTBfoy5f7M0vWjahdDv8AgvuKIlV+VT6KeT0ta7vsQqaMWXRbU/8Aqe5m2RhVEeTt3mz8Bikf9Eb5mzRf5fgSLjZDdepKPtNhrv5fbUQtMM7BpSxj9LuVXjTQ4ZafK0rWO5T6qXr56lqeGzVTvRFi13WRyApchKK6J6sX4LZlL0IIMT7fyaoSt2IOBGNYzAe5uQQOalNe4tq8yn0iPPFWFkuoeTbkl9yQdbxb32LEdhnIlIhB/lISMCO/okzB7SSDhD3dzl87cqndFsyMnMDGeZT6BHlirsG/8Cxl0J3qb4JWiEwLWntPVGHVdxLg0+qUtQjkdxYGFuvwyMKWDlSx5ZwFZAtcTYTmtWK+rDPKoniI88VLGZI/D26JSsvkEC733Y8OCYb/AKCz/UgWn5gRWBklBmj5EKxD/wB6aMNR2yEoBY9CCaD9DSjG45FFtRi7tSSjF70atwzyKfXTzRU/3TBa/RdFyXuO+lbUHT0stVy29SSc8R/6kRAdrfJjQ92PvbeEi7I2936LWQGX/ZkfykeipMQCq8axUT3UFmwr8gR9BB5FeTA/XSnatdkaGlGIyc3HsbRHEuwYdK2RLMZek6FGE3Kz8GO8fk1A5Q9ltGJQZ0nBMoGhS9AeYzeSvZgOkO7Ikzdx490OnyyD6aefRkT8PQnbaxP246aVXLCDwZDQ/cy3sn+aRr3YpR2wUhQsemrtFWYs8rKuM74ksx5aiotwFvydrEhzJ6oaEdzNKD4VWk0ICx7F5QvzU+ink04RagRVee9IJA2VNOiCKR60MZauX5nayUcbUObG1BKHen8E8SrwTWQhiS8yPJIPoIPJpGGWRSEQqs29q9vyETZXJjeVpjwklvA1rWjGb3exjdWKNHaPAq4GntCMFY8mn1iPMERHy/RwaiXmGNDX8hOBM/Rwc6ex/WyafMIIQ8KrZtjB0DICFkXOjySK3m09rEoqd1ybZwtF/A3BRnlMcroeRT6aeTSZPHw6J69vIbnMui9TIVubepHn5z/ZP2jE5/AgblDRU9rhmXv0vNp9ZoeXTv5rYh+9snCfqvCJY2e7N6iT/wAR/wDmDfpXYgz7Q/8AZhpZd2/RHK13Es+lpW/eLVntAax0vLp9NPPJl7Ifu2rfqDunIVdPwogSgI/S0oy7dVsycRMiqO6nlmonjTyjg1jg5OhhIIoX8D2InUxQajprUmW31WwqK0zR5ZqfVTziOb15FiisfoLvGNV/BiZfZS2QrB/7lWfWbDPLIPop5hc2gqs9mYmW7fwfsCVWAs022zLBwyHcoCYYllmT8jPPp9dPKJuaqmeyL+RJ7A38BpRjc5VmOyJkNiBQ1vdVNELCkovz0+umPuWXffQcsfBbLpaUX50yaI75cr7Qg3ygaRl0bIJPbAtSnn0+mmqL0q7KqL228lFRfgrq0rrVkuWZnEyr7s0vNDiMdkIViVj3GxHFHk0+iiyhbnFV8hpt2rhOUL8l9TNHdXnofsAcBZGLOJbUJ0SX5EpYp5dPqosoeVbUtSTaNQkiNnyl6C9FfgextdBEmklIbDxt+SYZPaKlnn0+umDuScKokhGzWWH8CUtIR0M0OPJNuge+1fFfPrIWHcWOWp2C0qywhAwGk/gsXrXicCq2dlIqGSFpqU/cdmne4hnkiorAsO/Q6/fVO3nmy/dqez8met+7JVZ7FBUkj2Q7ZojN+iBtpijyzWijB3E7hKPA/INWy3bG4378ofVZBfms7iRkkCbO92pYj/OHXeq+YVkq6o8+n0CwZI8YamU+2IZkuBIZcsTR742/PE91qmkrceJ0A66INWssI//aAAwDAQACAAMAAAAQIpm3/wD/AP8A/wBz2/t2Mdf/AIjpJJ630IK/iraN99ftO9ReIarYki9ZYKW9qYKVHYW2ns3nPJvUA7KTTNltkfHFFHPj1ggmk83Ee3H1tn56LnDKQ+E8lf7Kma52P32sOtBqba4pjKZ7PrX8s/6fQ6X9/wD71E+quCOcH7im3ztkFkr/ABqGV7P7ZGGu7+7ad/sYBnsrj/Hn/wB+C4Cxzy5A6add+pLb7p57+abCSf0BTBTbGJkGU7f5rYJJ7axTN8bIJADNewzp67vBb7776IIqa776tH6oZrOtsJ64VOMbfb7bYIJL777747Nf9fwGi7R4aYzGTLpIcoJ7L/7rJ7qwOv8AR+FKQfmWraS0Z6CG+OPArnlTCxw8yImqK6ge+6EzQCCCS+wPlOCn/wBxsZ66MMl+VvogggggggosjraP6tadjo2v1Asjlrgggg9w6yggkvvvpQoPsmbJSAkL9voggggggkoghsumqQpAgvXbsG//AC7I4IIIIIIIMILoaq7cD/8A9o7O7JZqu+DDDDDDDLHCm+qTQPKNsiLednQ+O2+v+/vvv++eiSi9OkbMFqRf3w5uD6mCCSSiKCOe+jL3rpd/AONrhTWmqOK2y2yiyiCuO/5TWGY8j+OClu/Ee++5/C+eKG9++ee3k9EO/8QAHxEAAgMBAQEBAQEBAAAAAAAAAAEQETEhIDBBUWFA/9oACAEDAQE/EF6fhj4NWqGqY4oenLUXZS8JWJUp2MwP4OyKBMcdKGtw5SsSrxseGfDF5o/VF/0SFaDsi0huEmxBU8UaMGGPxZcUYXB0yjRUuFISRS8V40zBhjiyxDLLDflCpsTiy4caZgyOXDZfhdOFbEbODp5TExrwvTBgc2NylcJNlJ0JUMav12JzRs4Q3BuKHzwqCxiEvVWNFYahqE52YMOKLhCVlzHZCVfB9P4lHSvFxowaS4Ss5VCVKvo1aK88I4aMDccsqJleK+NWNdEhicaHhh+F6YWNIazP9oc/NeUMGVGxnScMQkvkcdtF/otXkziMatZ/qJn6Uqg5s2YHjhxj6LU3BFdoxIfRkKRyo3DjRgzFQvPq1exsVR+Sj8nRgwON+38nJudMwZle/wDCx+w04o2YMDEb+bZYvOy7HXoa6UbMyI0Nebiyy5XhDdFpekjUbgcUNB+KiiiiivLP06Y1ITjRgZqE6Y1qH9WPBjUNZ+FjdMjNCyOUUUXN+6EoGfnylOjFzQxdKldULyNn54//xAAiEQACAgMAAgIDAQAAAAAAAAAAARExECAhMEBBUWFxoYH/2gAIAQIBAT8QqUZWV3dILTgsyCGocZJQROjRljc1RejtCu8DmEpzE5lJvghBJGWisY0LRIRcf0FfCyghIyeyxDSJYY1WxS4t8XH9hXwICb5Eo4SJEhMiPwfG38+BcV6kCU0OdiEVq3pA1Y1YgjRcUlSMQJS4INp6OA+hOdYxOUPUVi4QJSQqRLSRy4jhEtvDQLYliCUYqLCZXoR4h4mXwbjo5PZOBSJ0Z8wkQJwuKyuJHLxHR8QwuBtvw/aJyNZanAhg3RWJzC8wvskG/InAnOJwkoh4WHLiSWLEShEN+ZiOZeNBBXoWWJidqRUEfgHdMfiZEYeJKYKztCcw/M8QoKExwXuhAEylgahwwQ5HRBQfUJzitcEEvwAN8g1Y/UNL4Vx8DJYnB0UFBYbykyoX2lhheEcEuZqOheBOCF9jS/RpqLzFOR8Ez6NcJprUoychejTDg+C6QUEVaEvRXMOzvCn+iKRuCsWV6KvDoSWcMgUfsVi8icwdCR6QSkaJcyq/Z8ic4L4kU+nXlVhToWpQkPxy9L4sOhcP/8QAKRABAAIBAwMEAgMBAQEAAAAAAQARIRAxQVFhcSCBkaEwscHR8OFA8f/aAAgBAQABPxA5j72XMBcgT6r85jVHbWz1jL0jrm0V0mNvcRWaG9zEaPvcMNvQwMIbRvyMsvN92IMTcG3pLLYTcIV3XQjhfeV221nOgnaF2ZjGEQkAFAKA0M6ZyiW99G+RxgWnpm38hpUFIBSuka3aUfNEMMTR6/YwXrKhsdYIgjZCJqhEOzCHRoXzzqwpiyzGEIquxwQBqojJpdUVXLcZsQmwoeWPWlQAUFHbTmBbiEm0hgBjAFc9/SMuYst5vLZneDaOn7YbGvMrQ0C/R30qJBpEyJtLkVYzY6MQa0ACwzeSPubkxDaoQEcTFHsBSuw6bM2h1gdPAi5VajUGvu0NBcQsR1MpGrdWO1aM3mSOPegMsFuKOjenoGmFGY+fHnVX/wBm82miy/TjiOlzZLCU02QTy9ggeG2iKCKSusT5ntFd5mtuYGI5LdvKVGOrD8IRh3th5VtFsVEd1maqrdGC3BFKwdWZCn0QARTtKlSoLozgUgbHmYtk7jtIdmo3qbY4vXDeUtBGFu1JtIR1dRl+q5cIC0WJWZvTjhkiQQ5Mdw8yqyvebA7jrMHYHDEpzGFmG3eAoAI3JFR7ii4t2GgMQbTEMYul2lMKnd4hK3tcEKHE250VGFYkDNVdKhEL3YFsdmuXvLcxi45tvXD5T7mczdjpDf8AkzAwSqNKJ7yq0rTz0VKlSpaMDvK7zzjW+4AfBBLgXtsRpjbqPEEwp4eYzak3jvglZgA94qNYxBXCmIewqHdjsUH4YdAB2ipZipZDSN2LJTAo9L6lqp7jEDDTaCVxAmTRu5UNGehBh7ksA9cuPONkFn/q4MGlZWjK0qVrWrKJ2i8ECsfuCOUD2bj6OlmRju5CgeYm9nkz74Qy8ffJLG+wAsC07yT6Aotz7YEbvWcmZuX91FYbuD+5QBnmTuY87D3hYiOYEBV7IwMErvqrSojPPosDCuPlOahzi8kDi6JtPGtfkFhQ5UU+SMYpSbrn4R98UIwionOWCqR2EBUIdiIhhKZUogVKueEeyB0V3IlAbuPki5idhfugI5+1eSpSB0q33NzEHWpX4BbntC7uLzNcBAFS1Y1j+5tQAl/hVpQAHscr2lGvv/tCe6sofZiEUWcDeVoxlcCfWi3DUQGJfZdTaXL1q4gQWu9VmDlS+zG9niUmxN5PwwIRNkb9apRqI+zjOGoMkFL2/ubHj0VK9X3cM9iWiOALL+JiRzZT3ZfaXjaDBeZcNtG8BgwZd0Dq77QWFVDaO0ICiZJudZcSqgwBuuksw7kPl738xWbnoLOIrejEbFuC5YNuOZ+Hch9r7Ph8PMs9K+jlPt4kH2SsRq+39zY8ehfqB0e+z+jvAlBbL/C95U2lty4MvQLvG0GM5bxYpwQUALV2JYZkmCO69oeYBQdIyVrgMq6Rsh0ex79WBV0uzxBLcJu4ImaUC+jCN4gGi2toLx3GZ1damt47PZl2ONv8/UglM4Eemta5h3goe+Y2hVVBiYs6ZsPwomJ+N1ehHQs9+ex0J4h6AVKGVloWJR9TrCBiws4srG5MA8NevaGZ2vg4SFcuwd10OsK1Y9QH9wMVKmKKq6Bxgjt0HU2YxBGziWXfMV27ywjnWuJehp4m/R5Z906M3VTGMvRPSrRUe6XoucbvRESMdM29b9CyuIS22PVKiSuQX9SxN9AoJ1iy4rOyD/eZQwBQJmDxKAjobrt1hNOUm3d1MR/aQ2eEX5XwfPQiI4MdB0/tPbUBxpPaEmWM52R+ke2si/6xL7y5c3VFly5c2S4Qkf8AhiH8w0S3kOk+o2wKy84IoCfRwcHrFBRoc+TsSqsVplfwRnEEHctBLgxLlwr1sX9QRM9rPA+IRaIpI/uAuCUOoY/UP5lacx24cw0YFkzyVFF7JmJ3Z59HeM2DZ2GYnN+QyDcYuy0TjudRly5fwBs7Z/VxLrEj5ly9fLS0qoBtbDpFtyMjuuR9I3hqjrm8PRBCN3TDY8erNWu54gnnRLmnRCBszdA2GLYxVn7RzEASoSoAF30m1iYxVy9mElQKIgsAbq7R1gLSmHbqe8egq5i9VjGwiUTA8QcQFAYIFRJUr0BNgdiD0z5cHlRKIvrCWXmXUWIU94C1P81xG95cGeOlkcy+YcCq+h2QoArBzLIhwytF3RteGoY+DODx6USALVlpFl3nrFFLtfcOoiiL/wBiXUKvoIQEMUEIokKHEessSTYfR/MoQMT4xEf0TsMq6BGRWrBoOq/iFHagKleg/CJVRg27HtFZi9B3LpF69Il8CtNnrMrQWRcFddLoivWXRctjpeLs+pcblscjsJDQN8e94PENttLYHNcwoKZto5NGXgy8Hj0vMMyPc+ZiQBSTFm7VtxBDEAqaDeIykfYIfd5JgGNW/C+JzYINude/aE5YsO6cyiwYzf5Vin0fZ7Q/mVrwsICm+P79TE9G+8EUcllL2YLLLQvYejG3o8HKZ/if4LU+QzZtkOghhwij0G/6ltP1GHjj5XZ/Wly9EwpTuLcT4jcf8ifciziXFxiKd8eZfOC4lhjpnTx6AclEeAjoIpPR/wAZei4KlxUlBGm7mYAdsUMRgKVW03fELBOF16+CMbXLW/8ARF6Wo9UpaevLF9IHKKzJ/ZCiU7YF+ztAy35cteCBWqgK7QoZOTRjbsAcdRhgDR85bgjnq5dvEyYsDV29ukBH65P6JjisL9D9S5c/dHd4lzdLLq9bQh0P09kSKCJdzMEwDo4lwwqob8WcHiAymMQ0ZY4d4rNAxW22YjlhbMqhHEN68c3zEBhwc8ooO/C8R5gdfw1K6ehJesV2Vnr3QEatum7nY3J+wHeZMN5Rf16KOZR0M7wLidD9/cjXW0nIsBjCWVj0idvoPmHPme50lhm1brcOsVhS3STtF53A+49zVQXrgZnFBtAgdMDBq43iD5yl2Y3T3gAuwvy6t1QzBbC1eRWU9psfda/UXOTDmwwAVwfiPQy4xS1PVIAbetVMuJxxz4ITWdQ3W0KwbA+8u4Cf79wg7BWNwd9hgkthj40W3tM50Xv8MuZy+Xe+j0BcHTL0Xq/nJI8BAzFueqy/cuTmOgBUV4RGfF2fg6xAICnFQGewDj8Y39D+RAAopHmNaLTdZbCEsrKD5hddb6lV/AYSmxfsiWHn8WtU5cbbiQ6sXlb4mKeZmoaaGgVP2zbowrm2F32DBibu8MsZiMKXR2o3hZgUO058AGZRDnTFn0SJFl6cXLOs3gFMXFFcRkMGLczsIbDDf0v5N347JuGv7obPuTkL+iIdNitk5QlejYQ6OdSCI5HDFELB9ls/cOb7x8XOOhCYt2wUaIQSgVj70YXa0frQxN4wK8QdWD9wWNjqW3VhXkViPJdxeTwTMKMiHChP5mYecKcsQ/CH6lDaOikWF0eSkcvgiB2mNgM7rA9g+VjjevFBDROkN/Q6fMaiDw4uCOyem5cYGobMwFWqdYviBCd6fqGyVG9SXtsfFqZtABdtkBS8xYVdH6jz7yvvJhSccE33bHtozdgebCG1gj3lwIFSoimj8P5Q/cxURFIMLVa8hTETeHUX0hSrkoSowr7VZH5iOGdaMZ2/eBOAG1yAsz1SMbDHbd55JAnt66viIDlgOY3l/Pj4YMB6AD9SzrqjKZnro5ltzJOyEZvcN/Gl4rMpzCXsyrLma8SMG3YlkFL5n2Gj96ED40KqdoF5aD7uNFQwS5YNUi9cE4QiocQHU3Z5HaXhdCyEJrDbh8RleY3SJKit7l1YGnZ9TqQKiG+qDMI8XR7MBh0jYwwAPSg3yBAryus2T55YX9swgfebt7UKoze0JoMCeIASvI0cTF2b+YgtorDoGYM6kDbMlh+doNLyg42mfgw2m2CwsTd0HHu+gmVJXyYpTY7i50NDkjUeCDfzGlH5qLYL1IayDrlEWmyQRt8iiXNB2Gbe8AwAYA6aHoqVK1d9oEUi83CAVTAnzCqFcMhsfmYQU7VHYD7sN/IszFfJYpQViG48PkCpcIoVhMD7X61boe72m64lg2auEre9Iu1zoT3k2mUjBDd3TDYgJ7M+pn93drva3qZ0kIPcqEHsBoaqnhKDiITwldoGlSvU6kbIEHQhTmt8VxORtw3iFxlubSLEOGbzciC800vJEnI5k0HQ/qXpWXbF9ibJX5JUffRPyo5QBAtD8WG0ZdRCu7ABKAo0YjWcwGW6/AIAhmB6bdcypUr8ZpAKR5ISi1ti+GGhXBowFjjskQ5s+YvSdBftLD4mLAvrNgr7N5mNR6P3BQ2bNcQdD9SwrDn3ID3Ick2PdN2HKDmH482e0dBug7GJtDQFGra8xhJaq7qQ2Q9I/PUzqXRrwly/uLzKdvfrQmS6rJC5nXc9h+EMaEOLKfuAxcGlWTYDy/ULK2K0bL3jPLN55lm95SnEH0YT6yDR7RZZhx5yznVjbnOdjeJRYsPG849A/wDI61KJR6EAdUPufQrRUSyV831CUXyzZmXW0t6w494K8iE3fKBgYW6uE4jyOrHjUv1K0W2XdLlMqHHoG34LqCHqJiA6I4g/bOl8Ob2vAh7EfD+DPpTTiAJdj9zZ4arr9UsWDpBtA0NE5/VKmT8pwnG6IbEeE/dprVCq4qM76g+9EAEqoTvoY1PwbWFFW4ZZVfZMxSVE8DF4z+oSOQn1SJ8FNgFoY5rfee6J7ag1b1PodR6td9oYxrwF4Z+WeBJC8QcSyWWioEtg30xxBdG8Az1Iye9n3b1K/oIPMZ8wfAJ9dTUfmqBk6A5KYeqtXUzfZX4L17pl1BU23iKycQhClxq7ZRU2gJ3MBMF7Igblh8QSzAPrRSWDXGtdCUBsEO1sGNQ6X/5jR30dHaL/AAVjVyw7ZuTV4m/hsTddGIucQiUEFexBiEPK0KHE+mhhFvyYIKOBglyzmc2/aWCvM5XYIehf/oJcZxox1hvn93/mrpvgjVFvrLWCDxKYmw8QU5MmjEcd7NfxGczo+UbMwRHEwXshf8grZeZeY8R7Wxo8EqeNtfmHpv8A87egXohcdpjn/wCT/nRiprGibXDJ2JRatp4eGD/Wju01Cf4FhOtC+6YbYfnQ3gydA+NCt8vxT/sMad+R+pexu3yYzKyX79BK1Hj/AMq5nOjFaCyPVdsfxFjM14V+pRBzb5YJHBBeCFOqYghwBQO+0ZV5UN5vRWIPLSAss/LVF5lzIuzh7AIzIE9qyGrbLlSvy3Li1LgxZfeDGIzZly8TibdBH6gbRQvmW5daEp5fyxKJRBDtghO4AXttDa0fvYwjuHi8xArcEdpmvdpvwbELKt7IkV4D+2MNo9cvH9r/AOQUwRsEC11EE94vQt9WfSLcYLHS5JWlSvQfQdPQPNQjiqT6jOILb1XfCAAdoZLmPzsFwBAQVTs060S3CrxBd1FXmTdgzisQKR1IHKr7k4xLZdS7tHYGD3md6GLs4lA73mbtR0zLl/8AjXL9G+Nsd/rFwwB2i6YDmq+IcwO3v2hMsETj2NBpWpHl/wAgwBR2i1cHypzpiHmrJG4aIjHRVT9TFzMlWY88Qktp2U3hB1GXquXLly9OIOjHWY6xZcuDOZerd6XFxFivq4nYFi4gxh6UzLVAStDY8s5dpgDeIYQYjKJ7Vf8AMvtDvPspWgCC/AlbRwD4mxGOsgvlY0wS8sQqo93kg3toei5cH1X+OyXL1dosQHc59Ed60MDlRD9RBQABioQC+IZQ7xG4ZzthL8x5n30Jn7ZgTLwoXVI+p3jAQb/QS9G3kEci5Ii1gDoR9d6XLly9Nkwgy9Ll+lzDE5j1gc4PnG4ublyveAa3AjYy7tGgsTkMkaN0RvF1e5p+60frmxD5KfuDNFcaPJcEvEvrLiMuuwRw3SXZgb1uZgx9R+SssZn0LE3ICexMRY4QX/wjiXo1C6iv1E4iS8i2DzLWg6HQmyovkQj9c2kw8CWLqYsWb2n+eNyyMwfZT3iwuI6mSCUQOOHpFcPTcuDLhk1WXpea9C1Ll63el6PELrQ/EcYK0qhb8RUnM+5exMWSpjj9EqyKOw2e0YFKZHrN0+4nWb0bE+0T/W6xj6M/wd9Qm54gjDG0+8xqGL5dps/A+l5/Ic+jZ7QivkvzqRZT/Bq380+6jVLRw+InaqL2J//Z",
      "jenis_hewan" : _controllerJenisHewan.text,
      "deskripsi" : _controllerDeskripsiHewan.text,
      "x_kode_member" : "USR0000004",
      "tanggal_posting" : DateFormat('yyyy-MM-dd').format(now),
      "urgensi" : _levelUrgensi,
      "tanggal_expired" : "",
      "lokasi_map" : _alamat,
      "alamat_detail" : _controllerLokasiTambahan.text,
      "x_prov" : "5",
      "x_kota" : "90",
    };

    APIHelperNyul().updateData('nyul-codeigniter/index.php/rescue/post_rescue_home_klik/${widget.idPostRescue}', data).then((value) {
      Navigator.pop(context);
    });
  }

  void _checkConnectionThenExecute() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isEmpty && result[0].rawAddress.isEmpty) MyDialogs().simpleDialog(context, 'Kesalahan', 'Ada kesalahan koneksi internet.');
    } on SocketException catch (_) {
      MyDialogs().simpleDialog(context, 'Kesalahan', 'Kamu tidak ada koneksi internet.');
    }
  }

  late loc.LocationData _currentPosition;

  _getLatLong() async{
    loc.Location _location = loc.Location();

    bool _serviceEnabled;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    loc.PermissionStatus _permissionGranted;

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await _location.getLocation();

    _ambilDataAlamat();
  }

  String _alamat = '-';

  _ambilDataAlamat() async {
    // final Coordinates coordinates = new Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    // List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition.latitude!, _currentPosition.longitude!);

    setState(() => _alamat = '${placemarks.first.locality}, ${placemarks.first.subAdministrativeArea}');
  }

  @override
  void initState() {
    super.initState();

    _getLatLong();
    _getDataUserLogin();
    _checkConnectionThenExecute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(LineIcons.times), onPressed: () => MyDialogs().functionDialog(context, 'Konfirmasi', 'Kamu yakin tidak jadi posting?', () {
                      Navigator.pop(context);
                    })),
                    Text('Batal')
                  ],
                ),
              ),
              Center(child: Text('Tambah Posting Rescue', style: TextStyle(fontSize: 20.0),),),
              SizedBox(height: 20.0,),
              _isAmbilGambar ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(_image, fit: BoxFit.fill,)
                ),
              ) : Container(),
              SizedBox(height: 10,),
              MyContainer(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyTextField(
                      controller: _controllerJudulPostingan,
                      hintText: 'Judul Postingan',
                    ),
                    SizedBox(height: 10,),
                    Text('Lokasi', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Row(
                      children: <Widget>[
                        // Auto Wrap
                        Expanded(child: Text(_alamat, style: TextStyle(color: Colors.grey))),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15.0),
                            onTap: () => _ambilDataAlamat(),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                children: <Widget>[
                                  Text('ubah'),
                                  Icon(LineIcons.map)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyTextField(
                      controller: _controllerLokasiTambahan,
                      hintText: 'Informasi tambahan dari lokasi',
                    ),
                    SizedBox(height: 15,),
                    MyContainer(
                      width: double.infinity,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pilih Provinsi', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),),
                              Icon(LineIcons.angleRight, color: Colors.orange,)
                            ],
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    MyContainer(
                      width: double.infinity,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pilih Kota', style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),),
                              Icon(LineIcons.angleRight, color: Colors.orange,)
                            ],
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              MyContainer(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Deskripsi hewan', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0,),
                      Text('Tulis deskripsi mengenai kenapa hewan ini harus mendapatkan penanganan.', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 8.0,),
                      MyTextField(
                        controller: _controllerDeskripsiHewan,
                        hintText: 'Deskripsi hewan',
                      ),
                      SizedBox(height: 15,),
                      Text('Tentukan level urgensi penanganan rescue ini.', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 8.0,),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _levelUrgensi = 3),
                              child: Container(
                                color: _levelUrgensi == 3 ? Colors.orange[300] : Colors.grey[300],
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Text('Ringan'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _levelUrgensi = 2),
                              child: Container(
                                color: _levelUrgensi == 2 ? Colors.orange[300] : Colors.grey[300],
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Text('Sedang'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _levelUrgensi = 1),
                              child: Container(
                                color: _levelUrgensi == 1 ? Colors.orange[300] : Colors.grey[300],
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Text('Darurat'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      MyTextField(
                        controller: _controllerJenisHewan,
                        hintText: 'Jenis Hewan',
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: postAsAnonymous,
                        onChanged: (value) => _onChangePostAsAnonymousValue(value!),
                      ),
                      Text('Posting sebagai anonymous')
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => MyDialogs().simpleDialog(context, 'Posting sebagai anonymous ?', 'Jika kamu posting rescue secara anonymous/tanpa identitas, maka kamu tidak akan mendapatkan poin atau rating.'),
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(LineIcons.questionCircle),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.orange[400]
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => _postRescue(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Selesai', style: TextStyle(color: Colors.white),),
                            Icon(LineIcons.check, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}