import React, { Component } from 'react';
import { StyleSheet, Text, View, SafeAreaView, ActivityIndicator, TouchableOpacity } from 'react-native';
import { SliderBox } from 'react-native-image-slider-box';
import * as RNFS from 'react-native-fs';
import Icon from 'react-native-vector-icons/FontAwesome';

export default class Cow extends Component {
  constructor(props) {
    super(props);
    this.state = {
        nummer: this.props.navigation.getParam('nummer'),
        access: this.props.navigation.getParam('access'),
        refresh: this.props.navigation.getParam('refresh'),
        canLoad: true,
        images: [],
        ohrmarke: 0,
        rasse: '',
        farbtendenz: '',
        groesse: '',
        handkuh: null,
        holkuh: null,
        gruppe: '',
        error: '',
        loading: true,
        sliderRefresh: false,
    }
  }

  static navigationOptions = {
    header: () => false,
  }

  hashCode = (str) => {
      var hash = 0;
      if (str.length == 0) {
          return hash;
      }
      for (var i = 0; i < str.length; i++) {
          var char = str.charCodeAt(i);
          hash = ((hash<<5)-hash)+char;
          hash = hash & hash; // Convert to 32bit integer
      }
      return hash;
  }

  cacheNew = async (sources) => {
    let images = []
    for (let i = 0; i < sources.length; i++) {
      if (sources[i] != null) {
        let uri = 'https://cvapi.xandmedia.de/' + sources[i];
        let name = this.hashCode(uri);
        let path = `file://${RNFS.CachesDirectoryPath}${name}`;
        let image = await RNFS.exists(path);
        if(image) {
          images.push(path)
        }
        RNFS.downloadFile({fromUrl: uri, toFile: path}).promise.then(() => {
          images.push(path)
        });
      }
    }
    return images;
  }

  cache = async (source) => {
    let uri = 'https://cvapi.xandmedia.de/' + source;
    let name = this.hashCode(uri);
    let path = `file://${RNFS.CachesDirectoryPath}${name}`;
    let image = await RNFS.exists(path);
    if(image) {
      return path;
    }
    RNFS.downloadFile({fromUrl: uri, toFile: path}).promise.then(() => {
      return path;
    });
  }

  edit = () => {
    this.props.navigation.navigate('CowEdit', {
      nummer: this.state.nummer,
      ohrmarke: this.state.ohrmarke,
      rasse: this.state.rasse,
      farbtendenz: this.state.farbtendenz,
      groesse: this.state.groesse,
      holkuh: this.state.holkuh,
      handkuh: this.state.handkuh,
      gruppe: this.state.gruppe,
      access: this.state.access,
      refresh: this.state.refresh,
      images: this.state.images,
    });
  }

  load = async () => {
    if(this.state.canLoad){
      try {
        let response = await fetch('https://cvapi.xandmedia.de/kuh/1/' + this.state.nummer.toString() + '/', {
          method: 'GET',
          headers : {
            'Authorization': 'Bearer ' + this.state.access,
            'Content-Type': 'application/json',
          }
        });
        if(response.status == 200) {
          let data = await response.json();
          console.log(data);
          this.setState({
            nummer: data.number,
            ohrmarke: data.number_ear,
            rasse: data.race,
            farbtendenz: data.color_tendency,
            groesse: data.height,
            handkuh: data.manual,
            holkuh: data.fetch,
            gruppe: data.group,
          });
          this.setState({images: await this.cacheNew([data.image_one, data.image_two, data.image_three])})
          /* if(data.pic1 != null){
            this.state.images.push(await this.cache(data.pic1));
          }
          if(data.pic2 != null){
            this.state.images.push(await this.cache(data.pic2));
          }
          if(data.pic3 != null){
            this.state.images.push(await this.cache(data.pic3));
          } */
        } else if(response.status == 401) {
          let response = await fetch('https://cvapi.xandmedia.de/token/refresh/', {
            method: 'POST',
            headers : {
              Accept: 'application/json',
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              refresh: this.state.refresh,
            }),
          });
          if(response.status == 200) {
            let data = await response.json();
            this.setState({access: data.access});
            return await this.load();
          } else {
            this.setState({error: 'Ein Fehler ist aufgetreten. Bitte App neustarten.', canLoad: false});
            return [];
          }
        } else {
          this.setState({error: 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es demnächst erneut.'})
          return [];
        }
      } catch(error) {
        this.setState({error: error.message});
        return [];
      }
    }
  }

  componentDidMount(){
    this.load().then(() => {
      setTimeout(() => {this.setState({loading: false, sliderRefresh: true});}, 500);
    });
  }

  render() {
    if(this.state.loading) {
      return (
        <View style={styles.container}>
          <ActivityIndicator/>
        </View>
      );
    } else {
      return (
        <View style={styles.container}>
          <View style={styles.containerSlider}>
            <SliderBox images={this.state.images} refresh={this.state.sliderRefresh}/>
          </View>
          <View style={styles.content}>
            <View style={styles.containerLabel}>
              <Text style={[styles.text, styles.nummer]}>Nummer:</Text>
              <Text style={[styles.text, styles.ohrmarke]}>Ohrmarke:</Text>
              <Text style={[styles.text, styles.rasse]}>Rasse:</Text>
              <Text style={[styles.text, styles.farbtendenz]}>Farbtendenz:</Text>
              <Text style={[styles.text, styles.groesse]}>Größe:</Text>
              <Text style={[styles.text, styles.holkuh]}>Holkuh:</Text>
              <Text style={[styles.text, styles.handkuh]}>Handkuh:</Text>
              <Text style={[styles.text, styles.gruppe]}>Gruppe:</Text>
            </View>
            <View style={styles.containerText}>
              <Text style={[styles.text, styles.nummer]}>{this.state.nummer}</Text>
              <Text style={[styles.text, styles.ohrmarke]}>{[('0'.repeat(5 - this.state.ohrmarke.toString().length) + this.state.ohrmarke.toString()).slice(0, 2), ' ', ('0'.repeat(5 - this.state.ohrmarke.toString().length) + this.state.ohrmarke.toString()).slice(2)].join('')}</Text>
              <Text style={[styles.text, styles.rasse]}>{this.state.rasse}</Text>
              <Text style={[styles.text, styles.farbtendenz]}>{this.state.farbtendenz}</Text>
              <Text style={[styles.text, styles.groesse]}>{this.state.groesse}</Text>
              <Text style={[styles.text, styles.holkuh]}>{this.state.holkuh ? 'Ja' : 'Nein'}</Text>
              <Text style={[styles.text, styles.handkuh]}>{this.state.handkuh ? 'Ja' : 'Nein'}</Text>
              <Text style={[styles.text, styles.gruppe]}>{this.state.gruppe}</Text>
            </View>
          </View>
          <View>
            <TouchableOpacity onPress={this.edit} style={styles.penBtn}>
              <Icon name="pencil" size={30} color="#555" style={styles.penIcon}/>
            </TouchableOpacity>
          </View>
        </View>
      );
    }
  }
}

const styles = StyleSheet.create({
  container: {
  },
  containerSlider: {
      height: 200,
  },
  penBtn: {
    alignSelf: 'flex-end',
  },
  content: {
    flexDirection: 'row',
    margin: 5,
  },
  containerLabel: {
    flex: 1,
  },
  containerText: {
    flex: 2,
  },
  text: {
    fontSize: 18,
    margin: 2,
    borderRadius: 8,
  },
  nummer: {

  },
  ohrmarke: {

  },
  rasse: {

  },
  farbtendenz: {

  },
  groesse: {

  },
  holkuh: {

  },
  handkuh: {

  },
  gruppe: {

  },
});
