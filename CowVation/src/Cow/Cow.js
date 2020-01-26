import React, { Component } from 'react';
import { StyleSheet, Text, View, SafeAreaView, ActivityIndicator, TouchableOpacity } from 'react-native';
import { SliderBox } from 'react-native-image-slider-box';
import * as RNFS from 'react-native-fs';
import Icon from 'react-native-vector-icons/EvilIcons';

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

  cache = async (source) => {
    let uri = 'http://cowvation.62defd4pih.eu-central-1.elasticbeanstalk.com/' + source;
    let name = this.hashCode(uri);
    let path = `file://${RNFS.CachesDirectoryPath}${name}`;
    let image = await RNFS.exists(path);
    if(image) {
      return path;
    }
    RNFS.downloadFile({fromUrl: uri, toFile: path}).then(() => {
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
        let response = await fetch('http://cowvation.62defd4pih.eu-central-1.elasticbeanstalk.com/api/cow/' + this.state.nummer.toString() + '/', {
          method: 'GET',
          headers : {
            'Authorization': 'Bearer ' + this.state.access,
            'Content-Type': 'application/json',
          }
        });
        if(response.status == 200) {
          let data = await response.json();
          this.setState({
            nummer: data.nummer,
            ohrmarke: data.ohrmarke, 
            rasse: data.rasse,
            farbtendenz: data.farbtendenz,
            groesse: data.groesse,
            handkuh: data.handkuh,
            holkuh: data.holkuh,
            gruppe: data.gruppe,
          });
          if(data.pic1 != null){
            let uri = await this.cache(data.pic1)
            this.state.images.push(uri)
          }
          if(data.pic2 != null){
            let uri = await this.cache(data.pic2)
            this.state.images.push(uri)
          }
          if(data.pic3 != null){
            let uri = await this.cache(data.pic3)
            this.state.images.push(uri)
          }
        } else if(response.status == 401) {
          let response = await fetch('http://cowvation.62defd4pih.eu-central-1.elasticbeanstalk.com/token/refresh/', {
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
      this.setState({loading: false})
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
            <SliderBox images={this.state.images}/>
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
              <Icon name="pencil" size={40} color="#555"/>
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
