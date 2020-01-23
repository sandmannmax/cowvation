import React, { Component } from 'react';
import { StyleSheet, Text, View, SafeAreaView, TextInput, TouchableOpacity, Picker } from 'react-native';
import { SliderBox } from 'react-native-image-slider-box';
import CheckBox from '@react-native-community/checkbox';
import RNFetchBlob from 'react-native-fetch-blob';
import GLOBAL from './../Global/Global'

export default class CowEdit extends Component {
    constructor(props) {
        super(props);
        this.state = {
            nummerS: this.props.navigation.getParam('nummer').toString(),
            access: this.props.navigation.getParam('access'),
            refresh: this.props.navigation.getParam('refresh'),
            images: this.props.navigation.getParam('images'),
            imagesB64: [],
            ohrmarkeS: this.props.navigation.getParam('ohrmarke').toString(),
            rasse: this.props.navigation.getParam('rasse'),
            farbtendenz: this.props.navigation.getParam('farbtendenz'),
            groesse: this.props.navigation.getParam('groesse'),
            handkuh: this.props.navigation.getParam('handkuh'),
            holkuh: this.props.navigation.getParam('holkuh'),
            gruppe: this.props.navigation.getParam('gruppe'),
            error: '',
            sliderRefresh: false,
            addColor: '#000',
            delColor: '#aaa',
            addDisabled: false,
            delDisabled: true,
        }
        
        this.handleNummer = this.handleNummer.bind(this);
        this.handleOhrmarke = this.handleOhrmarke.bind(this);
        this.handleRasse = this.handleRasse.bind(this);
        this.handleFarbtendenz = this.handleFarbtendenz.bind(this);
        this.handleGroesse = this.handleGroesse.bind(this);
        this.handleHandkuh = this.handleHandkuh.bind(this);
        this.handleHolkuh = this.handleHolkuh.bind(this);
        this.handleGruppe = this.handleGruppe.bind(this);
    }

    handleNummer = (event) => {
        this.setState({nummerS: event.target.value});
    }

    handleOhrmarke = (event) => {
        this.setState({ohrmarkeS: event.target.value});
    }

    handleRasse = (event) => {
        this.setState({rasse: event.target.value});
    }

    handleFarbtendenz = (event) => {
        this.setState({farbtendenz: event.target.value});
    }

    handleGroesse = (event) => {
        this.setState({groesse: event.target.value});
    }

    handleHandkuh = (event) => {
        this.setState({handkuh: event.target.value});
    }

    handleHolkuh = (event) => {
        this.setState({holkuh: event.target.value});
    }

    handleGruppe = (event) => {
        this.setState({gruppe: event.target.value});
    }

    static navigationOptions = {
        header: () => false,
    }

    getBackData = (data) => {
        this.state.images.push(data.photo.uri);
        this.state.imagesB64.push(data.photo.base64);
        this.setState({sliderRefresh: true, delColor: '#000', delDisabled: false});
        if(this.state.images.length > 2) {
            this.setState({addColor: '#aaa', addDisabled: true});
        }
    }

    delPic = () => {
        this.state.images.pop();
        this.setState({sliderRefresh: true, addColor: '#000', addDisabled: false});
        if(this.state.images.length < 1) {
            this.setState({delColor: '#aaa', delDisabled: true});
        }
    }

    navCamera = () => {
        this.props.navigation.navigate('Camera', { goBackData: this.getBackData });
    }

    send = async () => {
        if(this.state.nummerS == '') {
            this.setState({error: "Nummer darf nicht leer sein!"});
        } else if(Number.isNaN(Number(this.state.nummerS)) || Number(this.state.nummerS) % 1 !== 0 ){
            this.setState({error: "Nummer ist ungültig"});
        } else if(this.state.ohrmarkeS == '') {
            this.setState({error: "Ohrmarke darf nicht leer sein!"});
        }  else if(Number.isNaN(Number(this.state.ohrmarkeS)) || Number(this.state.ohrmarkeS) % 1 !== 0){
            this.setState({error: "Ohrmarke ist ungültig"});
        } else if((Number(this.state.ohrmarkeS) / 99999) > 1){
            this.setState({error: "Ohrmarke darf nicht länger als 5 Stellen sein"});
        }else if(this.state.rasse == '' || this.state.farbtendenz == '' || this.state.groesse == '') {
            this.setState({error: "Mindestens eine weitere Angabe fehlt"});
        //} else if(this.state.images.length < 1) {
        //    this.setState({error: "Kein Bild vorhanden"});
        } else {
            this.setState({error: "Alle Angaben sind richtig"});
            let data = [
                { name: 'nummer', data: this.state.nummerS},
                { name: 'ohrmarke', data: this.state.ohrmarkeS},
                { name: 'rasse', data: this.state.rasse},
                { name: 'farbtendenz', data: this.state.farbtendenz},
                { name: 'groesse', data: this.state.groesse},
                { name: 'holkuh', data: this.state.holkuh ? 'True':'False'},
                { name: 'handkuh', data: this.state.handkuh ? 'True':'False'},
                { name: 'gruppe', data: this.state.gruppe},
            ]
            for(let i = 0; i < this.state.images.length; i++) {
                data.push({ name: ('pic' + (i+1).toString()), filename: (this.state.nummerS + '_pic' + (i+1).toString() + '.jpg'), type: 'image/jpeg', data: RNFetchBlob.wrap(this.state.images[i].slice(7)) });
            }
            let response = await RNFetchBlob.fetch('POST', 'http://cowvation.62defd4pih.eu-central-1.elasticbeanstalk.com/api/cow/' + this.state.nummerS + '/edit/', {
                Authorization: `Bearer ${this.state.access}`,
                'Content-Type': 'multipart/form-data'
            }, data);
        }
    }

    render() {
        return (
        <SafeAreaView style={styles.container}>
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
                    <Text style={[styles.text, styles.handkuhLabel]}>Handkuh:</Text>
                    <Text style={[styles.text, styles.gruppeLabel]}>Gruppe:</Text>
                </View>
                <View style={styles.containerText}>
                    <TextInput style={[styles.input, styles.nummer]} value={this.state.nummerS} onChangeText={text => this.setState({nummerS: text})}></TextInput>
                    <TextInput style={[styles.input, styles.ohrmarke]} value={this.state.ohrmarkeS} onChangeText={text => this.setState({ohrmarkeS: text})}></TextInput>
                    <TextInput style={[styles.input, styles.rasse]} value={this.state.rasse} onChangeText={text => this.setState({rasse: text})}></TextInput>
                    <TextInput style={[styles.input, styles.farbtendenz]} value={this.state.farbtendenz} onChangeText={text => this.setState({farbtendenz: text})}></TextInput>
                    <TextInput style={[styles.input, styles.groesse]} value={this.state.groesse} onChangeText={text => this.setState({groesse: text})}></TextInput>
                    <CheckBox style={[styles.input, styles.holkuh]} value={this.state.holkuh} onValueChange={value => this.setState({holkuh: value})}></CheckBox>
                    <CheckBox style={[styles.input, styles.handkuh]} value={this.state.handkuh} onValueChange={value => this.setState({handkuh: value})}></CheckBox>
                    <Picker style={[styles.input, styles.gruppe]} selectedValue={this.state.gruppe} onValueChange={(itemValue, itemIndex) => this.setState({gruppe: itemValue})}>                    
                        <Picker.Item label="Stall" value="stall" />
                        <Picker.Item label="Seperation" value="sep" />
                        <Picker.Item label="Abkalbebox" value="ak" />
                        <Picker.Item label="Trockengestellt" value="trock" />
                    </Picker>
                </View>
            </View>    
            <View style={styles.imgContainer}>
                <TouchableOpacity onPress={this.navCamera} disabled={this.state.addDisabled} style={styles.btn}>
                        <Text style={[styles.btnText, {color: this.state.addColor}]}>Bild hinzufügen</Text>
                </TouchableOpacity>
                <TouchableOpacity onPress={this.delPic} disabled={this.state.delDisabled} style={styles.btn}>
                        <Text style={[styles.btnText, {color: this.state.delColor}]}>Letztes Bild entfernen</Text>
                </TouchableOpacity>
                <TouchableOpacity onPress={this.send} style={styles.btn}>
                        <Text style={[styles.btnText]}>Hochladen</Text>
                </TouchableOpacity>
            </View> 
            <Text style={[styles.errorText]}>{this.state.error}</Text>
        </SafeAreaView>
        );
    }
}

const styles = StyleSheet.create({
    container: { 
    },
    containerSlider: { 
        height: 200,
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
        margin: 3.5,
    },
    input: {
        padding: -2,
        fontSize: 15,
        margin: 2,
        backgroundColor: '#ddd',
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
    handkuhLabel: {
        marginTop: 8,
    },
    gruppeLabel: {
        marginTop: 18,
    },
    imgContainer: {
        marginTop: 15,
    },
    btn: {
        paddingVertical: 4,
        marginVertical: 3,
    },
    btnText: {
        fontSize: 14, 
        textAlign: 'center',
    },
    errorText: {
        textAlign: 'center',
        fontSize: 12, 
        color: '#f85',
    },
});
